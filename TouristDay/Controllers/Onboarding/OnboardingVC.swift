/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/


class OnboardingVC: UIViewController {
    //MARK: - VARIABLES
    //MARK: - ARRAYS
    var tagsArr: [String] = []
    //MARK: - OUTLETS
    @IBOutlet weak var onboardTagsCVu: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerNibs()
        fetchTags()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerContentVertically()
    }
}
extension OnboardingVC{
    func fetchTags(){
        tagsArr = ["AI-Curated Plans",
                   "Route maps",
                   "Travel Plans",
                   "No Hassel Travel",
                   "Mood Dependant",
                   "Budget Friendly Options"
        ]
        onboardTagsCVu.reloadData()
    }
}
