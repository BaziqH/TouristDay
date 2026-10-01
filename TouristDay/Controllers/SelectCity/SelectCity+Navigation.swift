/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

    
extension SelectCityVC{
    func navigateToHome(){
        if let vc = Tabbar_Storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC {
            //navigationController?.pushViewController(vc, animated: true)
            
            vc.modalPresentationStyle = .fullScreen
            
            // Prevent the user from dismissing it with a downward swipe gesture
            vc.isModalInPresentation = true
            
            // Present the tab bar over the onboarding navigation controller
            self.present(vc, animated: false, completion: nil)
        }
    }
}
