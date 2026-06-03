/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

//MARK: - TABLE VIEW
extension ExploreDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return placesData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return loadMainLabelTVuCell(indexPath)
        } else if indexPath.section == 1 {
            return loadNavigationTVuCell(indexPath)
        } else if indexPath.section == 2 {
            return loadItineraryDetailsTVuCell(indexPath)
        } else if indexPath.section == 3 {
            return loadTagsTVuCell(indexPath)
        } else if indexPath.section == 4 {
            return loadHighlightsTVuCell(indexPath)
        } else if indexPath.section == 5 {
            return loadFullItineraryTVuCell(indexPath)
        }
        return UITableViewCell()
    }
}
//MARK: - LOAD CELLS
extension ExploreDetailVC{
    func loadMainLabelTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreDetTableView.dequeueReusableCell(withIdentifier: "MainLabelTVuCell", for: indexPath) as? MainLabelTVuCell else {
            return MainLabelTVuCell()
        }
        cell.configure()
        return cell
    }
    func loadNavigationTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreDetTableView.dequeueReusableCell(withIdentifier: "NavigationTVuCell", for: indexPath) as? NavigationTVuCell else {
            return NavigationTVuCell()
        }
        cell.backTap = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        return cell
    }
    func loadItineraryDetailsTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreDetTableView.dequeueReusableCell(withIdentifier: "ItineraryDetailsTVuCell", for: indexPath) as? ItineraryDetailsTVuCell else {
            return ItineraryDetailsTVuCell()
        }
        return cell
    }
    func loadTagsTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreDetTableView.dequeueReusableCell(withIdentifier: "TagsTVuCell", for: indexPath) as? TagsTVuCell else {
            return TagsTVuCell()
        }
        return cell
    }
    func loadHighlightsTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreDetTableView.dequeueReusableCell(withIdentifier: "HighlightsTVuCell", for: indexPath) as? HighlightsTVuCell else {
            return HighlightsTVuCell()
        }
        cell.configure(indexPath: indexPath, model: placesData[indexPath.row])
        return cell
    }
    func loadFullItineraryTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreDetTableView.dequeueReusableCell(withIdentifier: "FullItineraryTVuCell", for: indexPath) as? FullItineraryTVuCell else {
            return FullItineraryTVuCell()
        }
        return cell
    }
}
//MARK: - SETUP TABLE VIEW
extension ExploreDetailVC{
    
    func setupTableView(){
        exploreDetTableView.delegate = self
        exploreDetTableView.dataSource = self
        
        exploreDetTableView.rowHeight = UITableView.automaticDimension
        exploreDetTableView.estimatedRowHeight = 150
    }
    //MARK: - REGISTER NIBS
    func registerNibs(){
        let mainLabelNib = UINib(nibName: "MainLabelTVuCell", bundle: nil)
        exploreDetTableView.register(mainLabelNib, forCellReuseIdentifier: "MainLabelTVuCell")
        
        let navigateNib = UINib(nibName: "NavigationTVuCell", bundle: nil)
        exploreDetTableView.register(navigateNib, forCellReuseIdentifier: "NavigationTVuCell")
        
        let itineraryNib = UINib(nibName: "ItineraryDetailsTVuCell", bundle: nil)
        exploreDetTableView.register(itineraryNib, forCellReuseIdentifier: "ItineraryDetailsTVuCell")
        
        let tagNib = UINib(nibName: "TagsTVuCell", bundle: nil)
        exploreDetTableView.register(tagNib, forCellReuseIdentifier: "TagsTVuCell")
        
        let highlightsNib = UINib(nibName: "HighlightsTVuCell", bundle: nil)
        exploreDetTableView.register(highlightsNib, forCellReuseIdentifier: "HighlightsTVuCell")
        
        let fullItineraryNib = UINib(nibName: "FullItineraryTVuCell", bundle: nil)
        exploreDetTableView.register(fullItineraryNib, forCellReuseIdentifier: "FullItineraryTVuCell")
    }
}
