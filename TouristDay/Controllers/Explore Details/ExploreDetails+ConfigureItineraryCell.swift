//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

extension ExploreDetailVC {
    func planLoaded(){
        configureHighlightCell()
        configureItineraryCell(text: "View Full Itinerary")
    }
    
    func configureHighlightCell(){
        UIView.performWithoutAnimation {
            exploreDetTableView.reloadSections(IndexSet(integer: 4), with: .none)
            exploreDetTableView.layoutIfNeeded()
        }
    }
    
    func configureItineraryCell(isEnabled: Bool? = nil, text: String) {
        let isEnabled = isEnabled ?? (state == .loaded)
        if let cell = exploreDetTableView.cellForRow(at: IndexPath(row: 0, section: 5)) as? FullItineraryTVuCell {
            cell.configureForLoading(isEnabled: isEnabled, progressText: text)
        }
    }
    
    func updateProgressText(_ text: String) {
        let progressText = text
        configureItineraryCell(text: progressText)
    }
    
    func startLoadingMessages() {
        loadingTimer?.invalidate()
        messageIndex = 0
        updateProgressText(loadingMessages[0])

        loadingTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            guard let self else { timer.invalidate(); return }
            guard self.messageIndex < self.loadingMessages.count - 1 else {
                timer.invalidate()
                return
            }
            self.messageIndex += 1
            self.updateProgressText(self.loadingMessages[self.messageIndex])
        }
    }

    func stopLoadingMessages() {
        loadingTimer?.invalidate()
        loadingTimer = nil
    }
}
