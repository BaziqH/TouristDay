/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

//MARK: - TABLE VIEW
extension SelectCityVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return loadPopularCityTVuCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(currentCities[indexPath.row])
        let selectedCity = currentCities[indexPath.row].city
        let selectedCountry = currentCities[indexPath.row].country
        navigateToHome(selectedCity: selectedCity, selectedCountry: selectedCountry)
    }
}
//MARK: - LOAD CELLS
extension SelectCityVC{
    func loadPopularCityTVuCell(_ indexPath: IndexPath)->UITableViewCell{
        guard let cell = popularCityTVu.dequeueReusableCell(withIdentifier: "PopularCityTVuCell", for: indexPath) as? PopularCityTVuCell else {
            return PopularCityTVuCell()
        }
        cell.configure(model: currentCities[indexPath.row])
        return cell
    }
}
//MARK: - SETUP TABLE VIEW
extension SelectCityVC{
    
    func setupTableView(){
        popularCityTVu.delegate = self
        popularCityTVu.dataSource = self
        
        popularCityTVu.rowHeight = UITableView.automaticDimension
        popularCityTVu.estimatedRowHeight = 150
    }
    //MARK: - REGISTER NIBS
    func registerNibs(){
        let cityNib = UINib(nibName: "PopularCityTVuCell", bundle: nil)
        popularCityTVu.register(cityNib, forCellReuseIdentifier: "PopularCityTVuCell")
    }
}

    

