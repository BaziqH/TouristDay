//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

extension SelectCityVC{
    
    func generatePlan(vc: ExploreDetailVC, _ selectedCity: String, _ selectedMood: String, _ selectedBudget: String) {
        vc.loadViewIfNeeded()
        vc.startLoadingMessages()
        vc.selectedCity = selectedCity
        Task {
            var plan = Plan(title: "", activities: [])
            do {
                for try await event in planService.streamPlan(city: selectedCity, mood: selectedMood, budget: selectedBudget) {
                    switch event {
                    case .status:
                        continue
                    case .title(let title):
                        plan.title = title
                    case .activity(let activity):
                        plan.activities.append(activity)
                    case .done(let ids):
                        for i in plan.activities.indices where i < ids.count {
                            plan.activities[i].placeId = ids[i]
                        }
                    }
                    let snapshot = plan
                    guard !snapshot.activities.isEmpty else { continue }
                    await MainActor.run {
                        vc.plan = snapshot
                    }
                }
            } catch {
                await MainActor.run {
                    print("fetchPlan failed:", error)
                    vc.stopLoadingMessages()
                    vc.stopSkeleton()
                    // show error on detailsVC or pop back
                }
            }
        }
    }
}
