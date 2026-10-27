//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

extension ExploreDetailVC{
    func generateFullPlanDetails(vc: PlanDetailsVC){
        
        if !placeDetails.isEmpty {
            vc.placeDetails = self.placeDetails
            return
        }
        
        Task {
            do {
                guard let plan = plan else {
                    print("Plan not found")
                    return
                }
                guard let city = selectedCity else {
                    print("City not found")
                    return
                }
                let details = try await planService.fetchDetails(city: city, activities: plan.activities)
                await MainActor.run {
                    print(details.first?.phoneNumber ?? "0313")
                    self.placeDetails = details
                    vc.placeDetails = details
                }
            } catch {
                await MainActor.run {
                    print("fetchPlan failed:", error)
                    // show error on detailsVC or pop back
                }
            }
        }
    }
}
