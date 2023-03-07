//
//  DateSelectViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 06/03/23.
//

import Foundation


final class DateSelectViewModel {
    
    func userDefaults(piker: DefaultsName) {
        UserDefaults.standard.set(piker.datePicker, forKey: "service_date")
        UserDefaults.standard.set(piker.servico, forKey: "service_name")
        UserDefaults.standard.set(piker.serviceIcon, forKey: "service_icon")
        UserDefaults.standard.set(piker.servicoColor, forKey: "service_color")
    }
}
