//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

extension ExploreDetailVC{
    func goToPlanDetails() {
        if let vc = Storyboards.Plan_Details_Storyboard.instantiateViewController(withIdentifier: "PlanDetails") as? PlanDetailsVC {
            vc.loadViewIfNeeded()
            generateFullPlanDetails(vc: vc)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
