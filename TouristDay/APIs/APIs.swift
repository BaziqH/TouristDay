/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

    
enum PhotonAPIEndpoints{
    static let photonBaseURL = "https://photon.komoot.io/api/"
    
    static func citySearch(query: String) -> String {
        "\(photonBaseURL)?q=\(query)&limit=10&osm_tag=place:city"
    }
}
