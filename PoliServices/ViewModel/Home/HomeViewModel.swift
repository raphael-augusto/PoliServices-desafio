//
//  HomeViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 25/01/23.
//

import Foundation

//protocol DescriptionProtocol {
//    var descriptionName: String? { get }
////    var icon: String? { get }
//}

class HomeViewModel {

    func setupService(serviceDate: String) -> Date {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"

        // Convert String to Date
        let data = dateFormatter.date(from: serviceDate) ?? currentDate
        
        return data
    }
}
