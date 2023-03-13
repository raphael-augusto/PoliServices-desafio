//
//  HomeViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 25/01/23.
//

import Foundation
import UIKit


protocol HomeDelegate: AnyObject {
    func showService(data: SetupData)
    func showButton()
}


@available(iOS 13.0, *)
final class HomeViewModel {
    
    //MARK: - Variables
    private var timer: Timer?
    
    //MARK: - class Persistence data
    let persistence = Persistence()
    weak var delegate: (HomeDelegate)?
    

    //MARK: - Rules functions
    func setup() {
        let currentDate = Date()
        
        guard var service = persistence.getSetupData() else {
            delegate?.showButton()
            return
        }
        
        let data = setupService(serviceDate: service.serviceDate)
        let toCompleteService = timeLeftToCompleteService(finishDate: data)
        service.toCompleteService = toCompleteService

        //validation
        let hasService = data > currentDate
        
        if hasService {
            delegate?.showService(data: service)
            
        } else {
            persistence.removeUserDefaults()
            delegate?.showButton()
        }
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

    
    func alertNotification() -> String? {
        guard let service = persistence.getSetupData() else { return nil }
         let data = subtract15MinutesTimeService(from: service.serviceDate)
        
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
