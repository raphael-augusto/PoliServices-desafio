//
//  HomeViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 25/01/23.
//

import Foundation


class HomeViewModel {
    
    //MARK: - Variables
    private var timer: Timer?
    

    //MARK: - Rules functions
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
