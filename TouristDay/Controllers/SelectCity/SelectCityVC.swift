/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class SelectCityVC: UIViewController {
    //MARK: - VARIABLES
    var tVuCellHeight: CGFloat = 0
    private lazy var cellForHeight: PopularCityTVuCell = {
        let nib = Bundle.main.loadNibNamed("PopularCityTVuCell", owner: nil, options: nil)
        return nib?.first as! PopularCityTVuCell
    }()
    
    lazy var cityDropDown = DropDownManager(presentingVC: self)
    let citySearchService = CitySearchService()
    var debounceTimer: Timer?

    var searchResults: [PhotonProperties] = []
    //MARK: - ARRAYS
    var popularCities: [PopularCity] = []
    var currentCities: [PopularCity] = []
    
    //MARK: - OUTLETS
    @IBOutlet weak var popularCityTVu: UITableView!
    @IBOutlet weak var popularDesLbl: UILabel!
    @IBOutlet weak var roundedVu: DesignableView!
    @IBOutlet weak var roundedVuHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: DesignableSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
        setupSearchBar()
        fillData()
    }
}
//MARK: - FETCH DATA FROM API
extension SelectCityVC{
    func fillData(){
        popularCities = [PopularCity(city: "Paris",
                                     country: "France"),
                         PopularCity(city: "Tokyo",
                                     country: "Japan"),
                         PopularCity(city: "London",
                                     country: "United Kingdom"),
                         PopularCity(city: "New York",
                                     country: "United States"),
                         PopularCity(city: "Barcelona",
                                     country: "Spain"),
                         PopularCity(city: "Rome",
                                     country: "Italy"),
                         PopularCity(city: "Amsterdam",
                                     country: "Netherlands"),
                         PopularCity(city: "Dubai",
                                     country: "UAE")
                         
        ]
        currentCities = popularCities
        popularCityTVu.reloadData()
        tVuCellHeight = heightForCell(popularCity: popularCities[0], width: popularCityTVu.frame.width)
        DispatchQueue.main.async {
            self.resolveHeight(rowHeight: self.tVuCellHeight)
        }
    }
}
//MARK: - UIHELPER FUNCTIONS
extension SelectCityVC{
    func heightForCell(popularCity: PopularCity, width: CGFloat) -> CGFloat {

        cellForHeight.configure(model: popularCity)
        cellForHeight.bounds = CGRect(x: 0, y: 0, width: width, height: cellForHeight.bounds.height)
        cellForHeight.contentView.bounds = cellForHeight.bounds
        
        return cellForHeight.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
    }
    func resolveHeight(rowHeight: CGFloat) {
        let contentHeight = CGFloat(currentCities.count) * rowHeight
        let maxHeight =
        view.safeAreaLayoutGuide.layoutFrame.maxY -
        roundedVu.frame.origin.y
        self.roundedVuHeight.constant = min(contentHeight, maxHeight)
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
