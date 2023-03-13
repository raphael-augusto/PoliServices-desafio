//
//  Persistence.swift
//  PoliServices
//
//  Created by Raphael Augusto on 07/03/23.
//

import Foundation

class Persistence {
    
    
    func getSetupData() -> SetupData? {
        
        guard let serviceIcon  = UserDefaults.standard.string(forKey: "service_icon")  else { return nil }
        
        guard let serviceName  = UserDefaults.standard.string(forKey: "service_name")  else { return nil }
        
        guard let serviceColor = UserDefaults.standard.string(forKey: "service_color") else { return nil }
        
        guard let serviceDate  = UserDefaults.standard.string(forKey: "service_date")  else { return nil }
        
        
        return SetupData(toCompleteService: "",
                         hasService: false,
                         createDate: "",
                         serviceName: serviceName,
                         serviceColor: serviceColor,
                         serviceDate: serviceDate,
                         serviceIcon: serviceIcon)
    }
    
    
    func getSetupDataRemove() -> SetupCancel? {

        guard let serviceName  = UserDefaults.standard.string(forKey: "service_name")  else { return nil }

        guard let serviceColor = UserDefaults.standard.string(forKey: "service_color") else { return nil }

        guard let serviceDate  = UserDefaults.standard.string(forKey: "service_date")  else { return nil }
        
        guard let serviceIcon  = UserDefaults.standard.string(forKey: "service_icon")  else { return nil }

        return SetupCancel(startDate: "",
                           startTime: "",
                           closingDate: "",
                           closingTime: "",
                           createDate: "",
                           serviceName: serviceName,
                           serviceColor: serviceColor,
                           serviceDate: serviceDate,
                           serviceIcon: serviceIcon)
    }
    
    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_icon")
        UserDefaults.standard.removeObject(forKey: "service_color")
    }
}
