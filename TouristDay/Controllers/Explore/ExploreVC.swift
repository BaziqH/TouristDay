//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class ExploreVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var exploreTableView: UITableView!
    @IBOutlet var budgetBtnCollection: [UIButton]!
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var makePlanBtn: UIButton!
    
    var clickedBtn: UIButton?
    var makePlanClicked: ((Mood, Budget)->())?
    
    var mood: Mood = Mood.food
    var budget: Budget = Budget.low
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }
    @IBAction func budgetButtonClicked(_ sender: UIButton) {
        guard clickedBtn != sender else { return }
        clickedBtn = sender
        
        for btn in budgetBtnCollection {
            var config = btn.configuration
            config?.background.backgroundColor = (sender == btn) ? .white : .black
            config?.baseForegroundColor = (sender == btn) ? .black : .white
            btn.configuration = config
        }
        budget = Budget(rawValue: sender.tag)
    }
    @IBAction func makePlan(_ sender: Any){
        self.dismiss(animated: true){ [weak self] in
            guard let self = self else { return }
            self.makePlanClicked?(self.mood, self.budget)
        }
    }
}
