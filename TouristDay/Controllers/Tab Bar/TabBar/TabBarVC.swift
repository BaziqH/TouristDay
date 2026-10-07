/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    //MARK: - VARIABLES
    //MARK: - ARRAYS
    //MARK: - OUTLETS
    @IBOutlet weak var mainTabBar: UITabBar!
    
    var selectedCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        mainTabBar.delegate = self
        passDataToHome()
    }
    
    func passDataToHome(){
        guard let childVCs = self.viewControllers else { return }
        
        if let navVC = childVCs[0] as? UINavigationController,
           let destinationVC = navVC.viewControllers.first as? HomeVC {
            destinationVC.selectedCity = selectedCity ?? ""
        }
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
