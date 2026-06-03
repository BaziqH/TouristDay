//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class ExploreVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var exploreTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }
}
