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
    

    //MARK: - Rules functions
    func setup() -> SetupData {
        let currentDate = Date()
        guard let serviceName  = UserDefaults.standard.string(forKey: "service_name")  else { return SetupData(toCompleteService: "",
                                                                                                               hasService: false,
                                                                                                               serviceName: "",
                                                                                                               serviceColor: "",
                                                                                                               serviceDate: "") }
        
        guard let serviceColor = UserDefaults.standard.string(forKey: "service_color") else { return SetupData(toCompleteService: "",
                                                                                                               hasService: false,
                                                                                                               serviceName: "",
                                                                                                               serviceColor: "",
                                                                                                               serviceDate: "") }
        
        guard let serviceDate  = UserDefaults.standard.string(forKey: "service_date")  else { return SetupData(toCompleteService: "",
                                                                                                               hasService: false,
                                                                                                               serviceName: "",
                                                                                                               serviceColor: "",
                                                                                                               serviceDate: "") }
        
        let data = setupService(serviceDate: serviceDate)
        let toCompleteService = timeLeftToCompleteService(finishDate: data)
        let hasService = data > currentDate
        
        return SetupData(toCompleteService: toCompleteService,
                         hasService: hasService,
                         serviceName: serviceName,
                         serviceColor: serviceColor,
                         serviceDate: serviceDate)
    }
    
    
    
    func timeLeftToCompleteService(finishDate: Date) -> String {
        let currentDate = Date()
        let timeInterval = finishDate.timeIntervalSince(currentDate)
        let hoursLeft = Int(timeInterval / 3600)
        let minutesLeft = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        
        if hoursLeft > 0 {
            return "Faltam \(hoursLeft) hora(s) e \(minutesLeft) minuto(s) para o atendimento."
        } else if minutesLeft > 0 {
            return "Faltam \(minutesLeft) minuto(s) para o atendimento."
        } else {
            return "O serviço já começou."
        }
    }
    
    
    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
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
