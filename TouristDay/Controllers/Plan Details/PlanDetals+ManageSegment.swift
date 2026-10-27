//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

extension PlanDetailsVC{
    func manageSegmentViews(_ showMap: Bool) {
        UIView.performWithoutAnimation {
            planDetailsTVu.reloadSections(IndexSet(integer: 2), with: .left)
        }
    }
}
