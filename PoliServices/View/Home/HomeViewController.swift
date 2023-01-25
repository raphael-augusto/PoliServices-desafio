//
//  HomeViewController.swift
//  PoliServices
//
//  Created by Raphael Augusto on 13/01/23.
//

import UIKit

@available(iOS 13.0, *)
class HomeViewController: UIViewController{
    
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
        
        initTimer()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    
    private func setup() {
        let currentDate = Date()
        guard let serviceName = UserDefaults.standard.string(forKey: "service_name") else { return }
        guard let serviceDate = UserDefaults.standard.string(forKey: "service_date") else { return }

        let data = homeViewModel.setupService(serviceDate: serviceDate)
        let hasService = data > currentDate

        if hasService {
            homeView.serviceCardView.setupCardService(nameServiceText: serviceName, dateAndHourText: serviceDate)

        } else {
            UserDefaults.standard.removeObject(forKey: "service_date")
            UserDefaults.standard.removeObject(forKey: "service_name")
        }

        HomeView.animate(withDuration: 0.3) {
            self.homeView.cardServiceIsHidden(active: !hasService)
            self.homeView.serviceButtonIsHidden(active: hasService)
        }
    }
    
    
    private func initTimer() {
        let now: Date = Date()
        let calendar: Calendar = Calendar.current
        let currentSeconds: Int = calendar.component(.second, from: now)
        let timer = Timer(
            fire: now.addingTimeInterval(Double(60 - currentSeconds + 1)),
            interval: 60,
            repeats: true,
            block: { (t: Timer) in
                self.setup()
            })
        RunLoop.main.add(timer, forMode: .default)
        self.timer = timer
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
