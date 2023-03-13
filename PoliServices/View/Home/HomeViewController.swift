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
        homeViewModel.delegate = self
        
        homeViewModel.initTimer(setup: setupUI )
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
}


//MARK: - Setup UI Screen
@available(iOS 13.0, *)
extension HomeViewController: HomeDelegate {
    
    func setupUI(){
        homeViewModel.setup()
    }
    
    
    func showService(data: SetupData){
        homeView.serviceCard(icon: data.serviceIcon,
                             nameServiceText: data.serviceName,
                             dateAndHourText: data.serviceDate,
                             color: data.serviceColor,
                             textTime: data.toCompleteService
        )
    
        HomeView.animate(withDuration: 0.3) {
            self.homeView.cardServiceIsHidden(active: false)
            self.homeView.serviceButtonIsHidden(active: true)
        }
    }
    
    func showButton(){
        HomeView.animate(withDuration: 0.3) {
            self.homeView.cardServiceIsHidden(active: true)
            self.homeView.serviceButtonIsHidden(active: false)
        }
    }
}


//MARK: - check out alert
@available(iOS 13.0, *)
extension HomeViewController: UNUserNotificationCenterDelegate {
    
    //navigation screen in notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        navigationDetailsServiceScreen()

        completionHandler()
    }
}


//MARK: - New Service
@available(iOS 13.0, *)
extension HomeViewController: HomeViewDelegate {
    
    func newService() {
        navigationNewServiceScreen()
    }
}



//MARK: - Navigation Screens
@available(iOS 13.0, *)
extension HomeViewController {
    
    private func navigationDetailsServiceScreen() {
        let detailsService = DetailsViewController()
        let navVC  = UINavigationController(rootViewController: detailsService)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
    
    
    private func navigationNewServiceScreen() {
        let newService = ServiceViewController()
        let navVC  = UINavigationController(rootViewController: newService)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
}
