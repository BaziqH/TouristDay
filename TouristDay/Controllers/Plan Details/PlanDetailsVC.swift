/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class PlanDetailsVC: UIViewController {
    
    
    //MARK: - OUTLETS
    @IBOutlet weak var planDetailsTVu: UITableView!
    //MARK: - VARIABLES
    var showMap = false {
        didSet {
            guard oldValue != showMap else { return }
            manageSegmentViews(showMap)
        }
    }
    //MARK: - ARRAYS
    var placeDetails: [PlaceDetails] = [] {
        didSet {
            planDetailsTVu.reloadData()
            print(placeDetails)
        }
    }
    
    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func adoptPlan(_ sender: UIButton) {
        navigateToHome(selectedCity: "Lahore", selectedCountry: "Pakistan")
    }
}
