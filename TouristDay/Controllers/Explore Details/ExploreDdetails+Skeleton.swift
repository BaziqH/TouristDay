//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

extension ExploreDetailVC{
    func stopSkeleton(){
        shouldStopSkeleton = true
        configureItineraryCell(isEnabled: false, text: "Failed...")
        if let cell = exploreDetTableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? HighlightsTVuCell {
            cell.configureForSkeleton(showSkeleton: false, indexPath: IndexPath(row: 0, section: 4))
        }
    }
}
