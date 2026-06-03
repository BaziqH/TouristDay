//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class HomeVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }

}
