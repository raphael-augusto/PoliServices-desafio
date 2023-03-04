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
}

final class DetailsViewModel {

    //MARK: - Delegate and networking
    private let networking = Networking()
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
    
    
    var count: Int {
        return dataValue.count
    }
    

    func dataValueRow(row: Int) -> String {
        return dataValue[row].description
    }
    
    
    
    func setup() -> SetupCancel {
        guard let serviceIcon  = UserDefaults.standard.string(forKey: "service_icon")  else { return SetupCancel(startDate: "",
                                                                                                                 startTime: "",
                                                                                                                 closingDate: "",
                                                                                                                 closingTime: "",
                                                                                                                 createDate: "",
                                                                                                                 serviceName: "",
                                                                                                                 serviceColor: "",
                                                                                                                 serviceDate: "",
                                                                                                                 serviceIcon: "")}
        
        guard let serviceName  = UserDefaults.standard.string(forKey: "service_name")  else { return SetupCancel(startDate: "",
                                                                                                                 startTime: "",
                                                                                                                 closingDate: "",
                                                                                                                 closingTime: "",
                                                                                                                 createDate: "",
                                                                                                                 serviceName: "",
                                                                                                                 serviceColor: "",
                                                                                                                 serviceDate: "",
                                                                                                                 serviceIcon: "") }
        
        guard let serviceColor = UserDefaults.standard.string(forKey: "service_color") else { return SetupCancel(startDate: "",
                                                                                                                 startTime: "",
                                                                                                                 closingDate: "",
                                                                                                                 closingTime: "",
                                                                                                                 createDate: "",
                                                                                                                 serviceName: "",
                                                                                                                 serviceColor: "",
                                                                                                                 serviceDate: "",
                                                                                                                 serviceIcon: "") }
        
        guard let serviceDate  = UserDefaults.standard.string(forKey: "service_date")  else { return SetupCancel(startDate: "",
                                                                                                                 startTime: "",
                                                                                                                 closingDate: "",
                                                                                                                 closingTime: "",
                                                                                                                 createDate: "",
                                                                                                                 serviceName: "",
                                                                                                                 serviceColor: "",
                                                                                                                 serviceDate: "",
                                                                                                                 serviceIcon: "") }


        let data = setupService(serviceDate: serviceDate)
        let dateFormated = formatedData(data)
        let hourFormated = dateToTimeString(date: data)
           
        
        return SetupCancel(startDate: dateFormated,
                           startTime: hourFormated,
                           closingDate: dateFormated,
                           closingTime: hourFormated,
                           createDate: dateFormated,
                           serviceName: serviceName,
                           serviceColor: serviceColor,
                           serviceDate: serviceDate,
                           serviceIcon: serviceIcon)
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
    

    
    func removeDefaults() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_icon")
        UserDefaults.standard.removeObject(forKey: "service_color")
    }
}
