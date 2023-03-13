//
//  DateSelectViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 06/03/23.
//

import Foundation


final class DateSelectViewModel {
    
    func userDefaults(addDefaults: DefaultsName) {
        UserDefaults.standard.set(addDefaults.datePicker, forKey: "service_date")
        UserDefaults.standard.set(addDefaults.servico, forKey: "service_name")
        UserDefaults.standard.set(addDefaults.serviceIcon, forKey: "service_icon")
        UserDefaults.standard.set(addDefaults.servicoColor, forKey: "service_color")
    }
}
