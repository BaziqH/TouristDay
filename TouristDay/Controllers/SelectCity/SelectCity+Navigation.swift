/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

    
extension SelectCityVC{
    func openExploreSheet(){
        
        if let vc = Storyboards.Main_Storyboard.instantiateViewController(withIdentifier: "ExploreVC") as? ExploreVC{
            vc.makePlanClicked = {[weak self] in
                self?.navigateToExploreDetails()
            }
            vc.loadViewIfNeeded()
            BottomSheetViewController.presentContent(vc, from: self, tableView: vc.exploreTableView)
        }
    }
    
    func navigateToExploreDetails(){
        if let detailsVC = Storyboards.Main_Storyboard.instantiateViewController(withIdentifier: "ExploreDetailVC") as? ExploreDetailVC {
            self.navigationController?.pushViewController(detailsVC, animated: false)
        }
    }
}
