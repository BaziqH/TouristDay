/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

extension ExploreVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return loadMainLabelTVuCell(indexPath)
        }
        else if indexPath.section == 1{
            return loadOptionsTVuCell(indexPath)
        }
        return UITableViewCell()
    }
}
//MARK: - LOAD CELLS
extension ExploreVC{
    func loadMainLabelTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreTableView.dequeueReusableCell(withIdentifier: "MainLabelTVuCell", for: indexPath) as? MainLabelTVuCell else {
            return MainLabelTVuCell()
        }
        return cell
    }
    func loadOptionsTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = exploreTableView.dequeueReusableCell(withIdentifier: "OptionsTVuCell", for: indexPath) as? OptionsTVuCell else {
            return OptionsTVuCell()
        }
        cell.onTap = { [weak self] in
            if let detailsVC = self?.storyboard?.instantiateViewController(withIdentifier: "ExploreDetailVC") as? ExploreDetailVC {
                
                // Push ensures the Tab Bar stays visible
                self?.navigationController?.pushViewController(detailsVC, animated: false)
            }
        }
        return cell
    }
}
//MARK: - SETUP TABLE VIEW
extension ExploreVC{
    
    func setupTableView(){
        exploreTableView.delegate = self
        exploreTableView.dataSource = self
        
        exploreTableView.rowHeight = UITableView.automaticDimension
        exploreTableView.estimatedRowHeight = 150
    }
    //MARK: - REGISTER NIBS
    func registerNibs(){
        let mainLabelNib = UINib(nibName: "MainLabelTVuCell", bundle: nil)
        exploreTableView.register(mainLabelNib, forCellReuseIdentifier: "MainLabelTVuCell")

        let optionsNib = UINib(nibName: "OptionsTVuCell", bundle: nil)
        exploreTableView.register(optionsNib, forCellReuseIdentifier: "OptionsTVuCell")
    }
}
