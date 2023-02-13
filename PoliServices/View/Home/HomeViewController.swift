//
//  HomeViewController.swift
//  PoliServices
//
//  Created by Raphael Augusto on 13/01/23.
//

import UIKit

@available(iOS 13.0, *)
class HomeViewController: UIViewController{
    
    //MARK: - Variables
    private var timer: Timer?
    
    
    //MARK: - ViewModel
    private var homeViewModel = HomeViewModel()
    
    
    //MARK: - Properts
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self

        return view
    }()
    
    
    override func loadView() {
        self.view = homeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel.initTimer(setup: setup )
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    
    private func setup() {
        let currentDate = Date()
        guard let serviceName  = UserDefaults.standard.string(forKey: "service_name")  else { return }
        guard let serviceColor = UserDefaults.standard.string(forKey: "service_color") else { return }
        guard let serviceDate  = UserDefaults.standard.string(forKey: "service_date")  else { return }

        let data = homeViewModel.setupService(serviceDate: serviceDate)
        let toCompleteService = homeViewModel.timeLeftToCompleteService(finishDate: data)
        let hasService = data > currentDate

        if hasService {
            homeView.ToCompleteService(textTime: toCompleteService)
            homeView.serviceCardView.setupCardService(nameServiceText: serviceName,
                                                      dateAndHourText: serviceDate,
                                                      color: serviceColor)

        } else {
            UserDefaults.standard.removeObject(forKey: "service_date")
            UserDefaults.standard.removeObject(forKey: "service_name")
            UserDefaults.standard.removeObject(forKey: "service_color")
        }

        HomeView.animate(withDuration: 0.3) {
            self.homeView.cardServiceIsHidden(active: !hasService)
            self.homeView.serviceButtonIsHidden(active: hasService)
        }
    }
}


@available(iOS 13.0, *)
extension HomeViewController: HomeViewDelegate {
    
    func newService() {
        let newService = ServiceViewController()
        let navVC  = UINavigationController(rootViewController: newService)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
}
