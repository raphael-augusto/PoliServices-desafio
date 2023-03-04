//
//  Alert.swift
//  PoliServices
//
//  Created by Raphael Augusto on 27/02/23.
//

import Foundation

import UIKit

class Alert: NSObject {
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title: String, message: String, completion: (() -> Void )? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel) { action in
            completion?()
        }
        
        alertController.addAction(cancel)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
//    func getVerificateAlert(title: String, message: String, completion: (() -> Void )? = nil ) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
//            completion?()
//        }
//
//        alertController.addAction(okAction)
//
//        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
//            completion?()
//        }
//        alertController.addAction(cancelAction)
//
//        self.controller.present(alertController, animated: true, completion: nil)
//    }
    
    func getVerificateAlert(title: String, message: String, okCompletion: (() -> Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            okCompletion?()
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
            cancelCompletion?()
        }
        alertController.addAction(cancelAction)
        
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
}

