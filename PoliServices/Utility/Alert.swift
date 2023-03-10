//
//  Alert.swift
//  PoliServices
//
//  Created by Raphael Augusto on 27/02/23.
//

import Foundation

import UIKit
import UserNotifications

@available(iOS 13.0, *)
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
    
       
    //MARK: - MARK: - UserNotifications
    func checkForPermission(dateStr: String, title: String, body: String, isDaily: Bool) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification(dateStr: dateStr, title:title, body: body, isDaily: isDaily)
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) {
                    didAllow, error in
                        if didAllow {
                            self.dispatchNotification(dateStr: dateStr, title: title, body: body, isDaily: isDaily)
                        }
                    }
            default:
                return
            }
        }
    }
    
    
    func dispatchNotification(dateStr: String, title:String, body: String, isDaily: Bool) {
        let identifier  = "my-notification-service"
        let title       = title
        let body        = body
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content     = UNMutableNotificationContent()
        content.title   = title
        content.body    = body
        content.sound   = .default
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        
        guard let date = dateFormatter.date(from: dateStr) else {
            print("ERRO -> DateFormatter in alert notification")
            return
        }
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar notificação: \(error)")
            } else {
                print("Notificação agendada com sucesso")
            }
        }
    }
}

