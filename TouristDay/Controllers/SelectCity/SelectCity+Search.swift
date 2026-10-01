/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

    
extension SelectCityVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounceTimer?.invalidate()
        
        if searchText.isEmpty {
            currentCities = popularCities
            popularDesLbl.text = "Popular Cities"
            reloadAndResize()
            return
        }
        
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            
            self.citySearchService.searchCities(query: searchText) { results in
                print(results)
                self.currentCities = results.map { PopularCity(city: $0.name ?? "",
                                                               country: $0.country ?? "") }
                print(self.currentCities)
                self.popularDesLbl.text = "Search Results"
                self.reloadAndResize()
            }
        }
    }

    func reloadAndResize() {
        popularCityTVu.reloadData()
        popularCityTVu.layoutIfNeeded()
        resolveHeight(rowHeight: tVuCellHeight)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
//MARK: - SETUP SEARCH BAR
extension SelectCityVC{
    func setupSearchBar(){
        searchBar.delegate = self
    }
}
