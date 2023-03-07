//
//  HomeViewController.swift
//  PoliServices
//
//  Created by Raphael Augusto on 13/01/23.
//

import UIKit
import UserNotifications


@available(iOS 13.0, *)
class HomeViewController: UIViewController {
    
    //MARK: - Variables
    private var timer: Timer?
    private var alert: Alert?
//    private var notificationUtility = LocalNotification.shared
    
    
    //MARK: - ViewModel
    private var homeViewModel = HomeViewModel()
    
    
    //MARK: - Properts
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self

        return view
    }()
    
    
    //MARK: - life cycle
    override func loadView() {
        self.view = homeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        self.alert = Alert(controller: self)
        
        homeViewModel.initTimer(setup: setupUI )
        alertCheck()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
}


//MARK: - Setup UI Screen
@available(iOS 13.0, *)
extension HomeViewController {
    
    private func setupUI() {
        let setupData = homeViewModel.setup()
        
        if setupData.hasService {
            homeView.ToCompleteService(textTime: setupData.toCompleteService)
            homeView.serviceCardView.setupCardService(icon: setupData.serviceIcon,
                                                      nameServiceText: setupData.serviceName,
                                                      dateAndHourText: setupData.serviceDate,
                                                      color: setupData.serviceColor)

        } else {
            homeViewModel.removeUserDefaults()
        }

        HomeView.animate(withDuration: 0.3) {
            self.homeView.cardServiceIsHidden(active: !setupData.hasService)
            self.homeView.serviceButtonIsHidden(active: setupData.hasService)
        }
    }
}


//MARK: - check out alert
@available(iOS 13.0, *)
extension HomeViewController: UNUserNotificationCenterDelegate {
    
    
    private func alertCheck() {
        let dataTime = homeViewModel.timeService()
        
        if dataTime {
            alertService()
        }
    }
    
    
    private func alertService() {
        self.alert?.getVerificateAlert(title: "Atenção", message: "Deseja cancelar o serviço", okCompletion: {
            self.navigationScreen()
        })
    }
    
    
    private func alertNotification() {
        let setupData = homeViewModel.setup()
        guard let dataTime = homeViewModel.subtract15MinutesTimeService(from:setupData.serviceDate) else { return }
        
        alert?.checkForPermission(dateStr: dataTime,
                                  title: "Serviço",
                                  body: "faltam 15 minutos para finalizar o serviço.",
                                  isDaily: true)
    }
    
    //navigation screen in notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        navigationScreen()
        
        completionHandler()
    }
    
    
    private func navigationScreen() {
        let detailsService = DetailsViewController()
        let navVC  = UINavigationController(rootViewController: detailsService)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
}


//MARK: - Navigation newService
@available(iOS 13.0, *)
extension HomeViewController: HomeViewDelegate {
    
    func newService() {
        let newService = ServiceViewController()
        let navVC  = UINavigationController(rootViewController: newService)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
}
