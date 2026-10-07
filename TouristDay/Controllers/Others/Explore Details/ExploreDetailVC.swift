//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class ExploreDetailVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var exploreDetTableView: UITableView!
    //MARK: - VARIABLES
    var placesData: [PlacesDTO] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        setupTableView()
        registerNibs()
    }
}
//MARK: - FILL DATA
extension ExploreDetailVC{
    func fillData(){
        placesData = [
            PlacesDTO(number: 1, name: "Mystique Restaurant", rating: "4.6"),
            PlacesDTO(number: 2, name: "The Observatory", rating: "4.2"),
            PlacesDTO(number: 3, name: "Daily Deli Co.", rating: "4"),
            PlacesDTO(number: 4, name: "The Last Tribe", rating: "3.9"),
            PlacesDTO(number: 5, name: "Tuscany Courtyard", rating: "4.7")
        ]
    }
}
