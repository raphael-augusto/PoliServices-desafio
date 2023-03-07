//
//  HomeViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 25/01/23.
//

import Foundation



final class HomeViewModel {
    
    //MARK: - Variables
    private var timer: Timer?
    
    //MARK: - class Persistence data
//    private var persistenceData = Persistence()
    

    //MARK: - Rules functions
    func setup() -> SetupData {
        let currentDate = Date()
        
        guard let serviceIcon  = UserDefaults.standard.string(forKey: "service_icon")  else { return SetupData(toCompleteService: "",
                                                                                                               hasService: false,
                                                                                                               createDate: "",
                                                                                                               serviceName: "",
                                                                                                               serviceColor: "",
                                                                                                               serviceDate: "",
                                                                                                               serviceIcon: "") }
        
        guard let serviceName  = UserDefaults.standard.string(forKey: "service_name")  else { return SetupData(toCompleteService: "",
                                                                                                               hasService: false,
                                                                                                               createDate: "",
                                                                                                               serviceName: "",
                                                                                                               serviceColor: "",
                                                                                                               serviceDate: "",
                                                                                                               serviceIcon: "") }
        
        guard let serviceColor = UserDefaults.standard.string(forKey: "service_color") else { return SetupData(toCompleteService: "",
                                                                                                               hasService: false,
                                                                                                               createDate: "",
                                                                                                               serviceName: "",
                                                                                                               serviceColor: "",
                                                                                                               serviceDate: "",
                                                                                                               serviceIcon: "") }
        
        guard let serviceDate  = UserDefaults.standard.string(forKey: "service_date")  else { return SetupData(toCompleteService: "",
                                                                                                               hasService: false,
                                                                                                               createDate: "",
                                                                                                               serviceName: "",
                                                                                                               serviceColor: "",
                                                                                                               serviceDate: "",
                                                                                                               serviceIcon: "") }

       

        let data = setupService(serviceDate: serviceDate)
        let toCompleteService = timeLeftToCompleteService(finishDate: data)
        let hasService = data > currentDate
        
        return SetupData(toCompleteService: toCompleteService,
                         hasService: hasService,
                         createDate: "",
                         serviceName: serviceName,
                         serviceColor: serviceColor,
                         serviceDate: serviceDate,
                         serviceIcon: serviceIcon)
    }
    
    
    
    func timeLeftToCompleteService(finishDate: Date) -> String {
        let currentDate = Date()
        let timeInterval = finishDate.timeIntervalSince(currentDate)
        let hoursLeft = Int((timeInterval / 3600))
        let minutesLeft = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60) + 1
        
        if hoursLeft > 0 {
            return "Faltam \(hoursLeft) hora(s) e \(minutesLeft) minuto(s) para o atendimento."
        } else if minutesLeft > 0 {
            return "Faltam \(minutesLeft) minuto(s) para o atendimento."
        } else {
            return "O serviço já começou."
        }
    }
    
    
    func timeService() -> Bool {
        let serviceDate  = UserDefaults.standard.string(forKey: "service_date") ?? ""
        let data = setupService(serviceDate: serviceDate)
        
        let currentDate = Date()
        let timeInterval = data.timeIntervalSince(currentDate)
        let hoursLeft = Int(timeInterval / 3600)
        let minutesLeft = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)

        return hoursLeft == 0 && minutesLeft == 15 ? true : false
    }
       
    
    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_icon")
        UserDefaults.standard.removeObject(forKey: "service_color")
    }
    
    
    func setupService(serviceDate: String) -> Date {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"

        // Convert String to Date
        let data = dateFormatter.date(from: serviceDate) ?? currentDate

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


    func initTimer(setup: @escaping () -> ()) {
        let now: Date = Date()
        let calendar: Calendar = Calendar.current
        let currentSeconds: Int = calendar.component(.second, from: now)
        
        let timer = Timer(
            fire: now.addingTimeInterval(Double(60 - currentSeconds + 1)),
            interval: 60,
            repeats: true,
            block: { (t: Timer) in
                setup()
            })
        RunLoop.main.add(timer, forMode: .default)
        
        self.timer = timer
    }
}
