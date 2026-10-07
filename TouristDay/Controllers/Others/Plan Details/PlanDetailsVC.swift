/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class PlanDetailsVC: UIViewController {
    //MARK: - VARIABLES
    //MARK: - ARRAYS
    
    //MARK: - OUTLETS
    @IBOutlet weak var planDetailsTVu: UITableView!

    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNibs()
    }
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
