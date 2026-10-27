//******** Developed by Drudots Technologies **********/
//******** https://www.drudotstech.com **********//

class SearchCityVC: UIViewController {

    //MARK: - VARIABLES
    //MARK: - ARRAYS
    
    //MARK: - OUTLETS
    @IBOutlet weak var tableVu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }
}
