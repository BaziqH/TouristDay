/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class ExploreDetailVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var exploreDetTableView: UITableView!
    //MARK: - VARIABLES
    var shouldStopSkeleton = false
    var selectedCity: String?{
        didSet {
            print("explore has city: \(selectedCity ?? " ")")
        }
    }
    var plan: Plan? {
        didSet {
            guard let plan, !plan.activities.isEmpty else { return }
            state = .loaded
        }
    }
    var state: LoadingState = .loading {
        didSet {
            switch state {
            case .loading:
                exploreDetTableView.reloadData()
            case .loaded:
                planLoaded()
                stopLoadingMessages()
            }
        }
    }
    var placeDetails: [PlaceDetails] = []
    
    var loadingTimer: Timer?
    let loadingMessages = ["Searching places…",
                           "Checking opening hours…",
                           "Building your plan…"]
    var messageIndex = 0
    var planService = PlanService()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopLoadingMessages()
    }
}
