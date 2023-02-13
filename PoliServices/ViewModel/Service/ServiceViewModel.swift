//
//  ServiceViewModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 23/01/23.
//

import UIKit


protocol ServiceViewModelProtocols: AnyObject {
    func success()
    func failure()
}

class ServiceViewModel {

    //MARK: - Delegate and networking
    private let networking = Networking()
    weak var delegate: (ServiceViewModelProtocols)?
    
    private(set) var dataValue: [ServiceData]  = []
    

    init(delegate: ServiceViewModelProtocols) {
        self.delegate = delegate
    }
    
    
    //MARK: - Request api
    func fetchcCursesData() {
        networking.load(endpoint: .services) { [weak self] (response: Result<Service, NetworkinError>) in
            guard let self = self else { return }
            
            switch response {
            case let .success(data):
                self.dataValue = data.data
                self.delegate?.success()
                
                print("Data -> \(self.dataValue)")
                
            case let .failure(error):
                print("ViewModel -> \(error.localizedDescription)")
                self.delegate?.failure()
            }
        }
    }
    
    
    var count: Int {
        return dataValue.count
    }
    
    
    func getNames(indexPath: IndexPath) -> ServiceData {
        return dataValue[indexPath.row]
    }
}
