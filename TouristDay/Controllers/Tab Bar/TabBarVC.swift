/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    //MARK: - VARIABLES
    //MARK: - ARRAYS
    //MARK: - OUTLETS
    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        mainTabBar.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedViewController == viewController {
            if let navController = viewController as? UINavigationController {
                navController.popToRootViewController(animated: true)
            }
        }
        return true
    }
}
