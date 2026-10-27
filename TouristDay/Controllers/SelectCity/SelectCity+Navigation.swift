/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

    
extension SelectCityVC{
    func openExploreSheet(){
        if let vc = Storyboards.Main_Storyboard.instantiateViewController(withIdentifier: "ExploreVC") as? ExploreVC{
            vc.makePlanClicked = {[weak self] mood, budget in
                guard let self = self else { return }
                self.navigateToExploreDetails(mood, budget)
            }
            vc.loadViewIfNeeded()
            BottomSheetViewController.presentContent(vc, from: self, tableView: vc.exploreTableView)
        }
    }
    
    func navigateToExploreDetails( _ selectedMood: Mood, _ selectedBudget: Budget){
        guard let detailsVC = Storyboards.Main_Storyboard.instantiateViewController(withIdentifier: "ExploreDetailVC") as? ExploreDetailVC else { return }
        self.navigationController?.pushViewController(detailsVC, animated: false)
        generatePlan(vc: detailsVC, selectedCity.city, selectedMood.promptValue, selectedBudget.promptValue)
    }
}
