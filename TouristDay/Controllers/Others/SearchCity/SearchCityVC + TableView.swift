//******** Developed by Drudots Technologies **********/
//******** https://www.drudotstech.com **********//

extension SearchCityVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        loadCityRowTVC(indexPath)
    }
}
//MARK: - LOAD CELLS
extension SearchCityVC{
    func loadCityRowTVC(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = tableVu.dequeueReusableCell(withIdentifier: "CityRowTVC", for: indexPath) as? CityRowTVC else {
            return CityRowTVC()
        }
        return cell
    }
}
//MARK: - SETUP TABLE VIEW
extension SearchCityVC{
    func setupTableView(){
        tableVu.delegate = self
        tableVu.dataSource = self
        
        tableVu.rowHeight = UITableView.automaticDimension
        tableVu.estimatedRowHeight = 150
    }
    func registerNibs(){
        tableVu.register(UINib(nibName: "CityRowTVC", bundle: nil), forCellReuseIdentifier: "CityRowTVC")
    }
}
