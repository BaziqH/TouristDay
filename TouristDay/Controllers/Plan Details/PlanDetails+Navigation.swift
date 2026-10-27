//
//  PlanDetails+Navigation.swift
//  TouristDay
//
//  Created by BaziqH on 07/10/2026.
//

extension PlanDetailsVC{
    func navigateToHome(selectedCity: String, selectedCountry: String){
        if let vc = Storyboards.Main_Storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
            vc.selectedCity = selectedCity
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
