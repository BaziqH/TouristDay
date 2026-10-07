//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class HomeVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var homeTableView: UITableView!
    var selectedCity: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide navbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Remove all from navigation stack except HomeVC
        if let navigationStack = self.navigationController?.viewControllers {
            let filteredStack = navigationStack.filter { $0 is HomeVC }
            self.navigationController?.setViewControllers(filteredStack, animated: false)
        }
    }
    @IBAction func goBackToSelectCity(_ sender: Any) {
        self.dismiss(animated: false)
//        navigationController?.popViewController(animated: true)
    }
    
}
