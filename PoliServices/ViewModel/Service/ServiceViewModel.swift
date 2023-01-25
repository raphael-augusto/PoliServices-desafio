//
//  ServiceViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 23/01/23.
//

import UIKit


protocol DescriptionProtocol {
    var descriptionName: String? { get }
//    var icon: String? { get }
}

class ServiceViewModel {

    private(set) var dataValue: [DescriptionProtocol]  = [ServiceData(descriptionName: "Código"),//,  icon: "pencil.slash"),
                                                          ServiceData(descriptionName: "Carreira"),//,icon: "graduationcap.circle.fill"),
                                                          ServiceData(descriptionName: "Entrevista"), //,icon: "books.vertical.fill"),
                                                          ServiceData(descriptionName: "Feedback") //,icon: "scribble.variable"),
    ]
    
    
    var count: Int {
        return dataValue.count
    }
    
    
    func getNames(indexPath: IndexPath) -> DescriptionProtocol {
        return dataValue[indexPath.row]
    }
}
