//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class ExploreVC: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var exploreTableView: UITableView!
    @IBOutlet var budgetBtnCollection: [UIButton]!
    @IBOutlet weak var budgetView: UIView!
    
    var clickedBtn: UIButton?
    var makePlanClicked: (()->())?
    
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
    }
    @IBAction func makePlan(_ sender: Any){
        self.dismiss(animated: true){ [weak self] in
            self?.makePlanClicked?()
        }
    }
}
