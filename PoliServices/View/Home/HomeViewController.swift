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
        
        homeViewModel.initTimer(setup: setupUI )
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    
    private func setupUI() {
        let setupData = homeViewModel.setup()

        if setupData.hasService {
            homeView.ToCompleteService(textTime: setupData.toCompleteService)
            homeView.serviceCardView.setupCardService(nameServiceText: setupData.serviceName,
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


@available(iOS 13.0, *)
extension HomeViewController: HomeViewDelegate {
    
    func newService() {
        let newService = ServiceViewController()
        let navVC  = UINavigationController(rootViewController: newService)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
}
