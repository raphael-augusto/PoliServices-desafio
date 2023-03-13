//
//  DateSelectViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 06/03/23.
//

import Foundation


@available(iOS 13.0, *)
final class DateSelectViewModel {
    
    let persistence = Persistence()

    func alertNotification() -> String? {
        guard let service = persistence.getSetupData() else { return nil }
        let data = subtract15MinutesTimeService(from: service.serviceDate)
        
        return data
    }
    
    
    func subtract15MinutesTimeService(from dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        guard let date = dateFormatter.date(from: dateStr) else {
            return nil
        }
        
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .minute, value: -15, to: date)!
        
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let newDateStr = dateFormatter.string(from: newDate)
        return newDateStr
    }
    
    
    func userDefaults(addDefaults: DefaultsName) {
        UserDefaults.standard.set(addDefaults.datePicker, forKey: "service_date")
        UserDefaults.standard.set(addDefaults.servico, forKey: "service_name")
        UserDefaults.standard.set(addDefaults.serviceIcon, forKey: "service_icon")
        UserDefaults.standard.set(addDefaults.servicoColor, forKey: "service_color")
    }
}
