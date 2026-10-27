/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

extension PlanDetailsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            // numberOfRowsInSection, section 2
            return showMap ? 1 : placeDetails.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return loadPlanDetailsTVuCell(indexPath)
        } else if indexPath.section == 1 {
            return loadSegmentTVuCell(indexPath)
        } else if indexPath.section == 2 {
            return showMap ? loadMapTvuCell(indexPath) : loadPlacesTVuCell(indexPath)
        } else {
            return UITableViewCell()
        }
    }
}
//MARK: - LOAD CELLS
extension PlanDetailsVC{
    func loadPlanDetailsTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = planDetailsTVu.dequeueReusableCell(withIdentifier: "PlanDetailsTVuCell", for: indexPath) as? PlanDetailsTVuCell else {
            return PlanDetailsTVuCell()
        }
        return cell
    }
    func loadSegmentTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = planDetailsTVu.dequeueReusableCell(withIdentifier: "SegmentTVuCell", for: indexPath) as? SegmentTVuCell else {
            return SegmentTVuCell()
        }
        cell.showMap = { [weak self] showMap in
            guard let self = self else { return }
            self.showMap = showMap
        }
        return cell
    }
    func loadPlacesTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = planDetailsTVu.dequeueReusableCell(withIdentifier: "PlacesTVuCell", for: indexPath) as? PlacesTVuCell else {
            return PlacesTVuCell()
        }
        let isFirst = indexPath.row == 0
        let isLast = indexPath.row == placeDetails.count - 1
        
        cell.configure(placeNo: indexPath.row + 1,
                       isFirst: isFirst,
                       isLast: isLast,
                       model: placeDetails[indexPath.row])
        return cell
    }
    func loadMapTvuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = planDetailsTVu.dequeueReusableCell(withIdentifier: "MapTVuCell", for: indexPath) as? MapTVuCell else {
            return MapTVuCell()
        }
        guard !placeDetails.isEmpty else { return cell }
        print(placeDetails)
        cell.configure(places: placeDetails)
        return cell
    }
}
//MARK: - SETUP TABLE VIEW
extension PlanDetailsVC{
    
    func setupTableView(){
        planDetailsTVu.delegate = self
        planDetailsTVu.dataSource = self
        
        planDetailsTVu.rowHeight = UITableView.automaticDimension
        planDetailsTVu.estimatedRowHeight = 150
    }
    //MARK: - REGISTER NIBS
    func registerNibs(){
        let planDetailNib = UINib(nibName: "PlanDetailsTVuCell", bundle: nil)
        planDetailsTVu.register(planDetailNib, forCellReuseIdentifier: "PlanDetailsTVuCell")
        
        let segmentNib = UINib(nibName: "SegmentTVuCell", bundle: nil)
        planDetailsTVu.register(segmentNib, forCellReuseIdentifier: "SegmentTVuCell")
        
        let placesNib = UINib(nibName: "PlacesTVuCell", bundle: nil)
        planDetailsTVu.register(placesNib, forCellReuseIdentifier: "PlacesTVuCell")
        
        let mapNib = UINib(nibName: "MapTVuCell", bundle: nil)
        planDetailsTVu.register(mapNib, forCellReuseIdentifier: "MapTVuCell")
    }
}


