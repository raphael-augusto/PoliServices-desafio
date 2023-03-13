//
//  DetailsViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 27/02/23.
//

import Foundation
import UIKit


protocol DetailsViewModelProtocols: AnyObject {
    func success()
    func failure()
    func removeService(data: SetupCancel)
    func showButton()
}


final class DetailsViewModel {

    //MARK: - Delegate and networking
    private let networking = Networking()
    private let persistence = Persistence()
    
    weak var delegate: (DetailsViewModelProtocols)?
    
    private(set) var dataValue: [DetailsElement]  = []
    
    
    init(delegate: DetailsViewModelProtocols) {
        self.delegate = delegate
    }
    
    
    //MARK: - Request api
    func fetchcCursesData() {
        networking.load(endpoint: .reasons) { [weak self] (response: Result<Details, NetworkinError>) in
            guard let self = self else { return }
            
            switch response {
            case let .success(data):
                self.dataValue = data
                self.delegate?.success()
                print("Data -> \(self.dataValue)")
                
            case let .failure(error):
                print("ViewModel -> \(error.localizedDescription)")
                self.delegate?.failure()
            }
        }
    }
    
    
    func postCancelOrder(reason: String) {
        networking.post(endpoint: .cancelReason, parameters: ["reason": reason]) { [weak self]  (response: Result<CancelResponse, NetworkinError>) in
            
            guard let self = self else { return }
                        
            switch response {
            case let .success(data):
                print("DataPost -> \(data)")
                self.delegate?.success()
                
            case let .failure(error):
                print("ErroPost -> \(error.localizedDescription)")
                self.delegate?.failure()
            }
        }
    }
    
    //MARK: - Piker view
    var count: Int {
        return dataValue.count
    }
    

    func dataValueRow(row: Int) -> String {
        return dataValue[row].description
    }
    
    
    //MARK: - Data visualization rules
    func setupRemove() {
        
        guard var service = persistence.getSetupDataRemove() else {
            delegate?.showButton()
            return
        }


        let data = setupService(serviceDate: service.serviceDate)
        let dateFormated = formatedData(data)
        let hourFormated = dateToTimeString(date: data)
        
        service.startDate   = dateFormated
        service.startTime   = hourFormated
        service.closingDate = dateFormated
        service.closingTime = hourFormated
        service.createDate  = dateFormated
        
        let finishDate = (timeFinish())
        
        if finishDate {
            delegate?.removeService(data: service)

        } else {
            delegate?.showButton()
        }
    }
    
    
    private func setupService(serviceDate: String) -> Date {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"

        // Convert String to Date
        let data = dateFormatter.date(from: serviceDate) ?? currentDate

        return data
    }
    
    
    func formatedData(_ data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd 'de' MMMM 'de' yyyy"
        return dateFormatter.string(from: data)
    }

    
    func dateToTimeString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }

    
    func timeFinish() -> Bool {
        let serviceDate  = UserDefaults.standard.string(forKey: "service_date") ?? ""
        let data = setupService(serviceDate: serviceDate)
        
        let currentDate = Date()
        let timeInterval = data.timeIntervalSince(currentDate)
        let hoursLeft = Int(timeInterval / 3600)

        return hoursLeft <= 2 ? true : false
    }
    
    func removeDefaulst() {
        persistence.removeUserDefaults()
    }
}
