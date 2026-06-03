/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return loadHeaderInfoTVuCell(indexPath)
        }
        else if indexPath.section == 1{
            return loadMapTVuCell(indexPath)
        }
        else if indexPath.section == 2{
            return loadLocationsTVuCell(indexPath)
        }
        return UITableViewCell()
    }
}
//MARK: - LOAD CELLS
extension HomeVC{
    func loadHeaderInfoTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "HeaderInfoTVuCell", for: indexPath) as? HeaderInfoTVuCell else {
            return HeaderInfoTVuCell()
        }
        return cell
    }
    func loadMapTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "MapTVuCell", for: indexPath) as? MapTVuCell else {
            return MapTVuCell()
        }
        return cell
    }
    func loadLocationsTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "LocationsTVuCell", for: indexPath) as? LocationsTVuCell else {
            return LocationsTVuCell()
        }
        return cell
    }
}
//MARK: - SETUP TABLE VIEW
extension HomeVC{
    
    func setupTableView(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.estimatedRowHeight = 150
    }
    //MARK: - REGISTER NIBS
    func registerNibs(){
        let headerNib = UINib(nibName: "HeaderInfoTVuCell", bundle: nil)
        homeTableView.register(headerNib, forCellReuseIdentifier: "HeaderInfoTVuCell")

        let mapNib = UINib(nibName: "MapTVuCell", bundle: nil)
        homeTableView.register(mapNib, forCellReuseIdentifier: "MapTVuCell")
        
        let locationsNib = UINib(nibName: "LocationsTVuCell", bundle: nil)
        homeTableView.register(locationsNib, forCellReuseIdentifier: "LocationsTVuCell")
    }
}
