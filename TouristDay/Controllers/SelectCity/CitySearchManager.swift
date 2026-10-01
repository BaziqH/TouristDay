/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

    
class CitySearchService {
    
    func searchCities(query: String, completion: @escaping ([PhotonProperties]) -> Void) {
        guard !query.isEmpty else {
            completion([])
            return
        }
        
        let urlString = PhotonAPIEndpoints.citySearch(query: query)
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PhotonResponse.self, from: data)
                let properties = result.features.map { $0.properties }
                DispatchQueue.main.async {
                    completion(properties)
                }
            } catch {
                print("Decode error:", error)
                completion([])
            }
        }.resume()
    }
}
