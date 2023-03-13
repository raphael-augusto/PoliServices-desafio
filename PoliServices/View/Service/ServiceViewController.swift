//
//  ServiceViewController.swift
//  PoliServices
//
//  Created by Raphael Augusto on 22/01/23.
//

import UIKit


@available(iOS 13.0, *)
class ServiceViewController: UIViewController {

    //MARK: - ViewModel
    private var serviceViewModel: ServiceViewModel?
    
    
    //MARK: - Properts
    private lazy var serviceView: ServiceView = {
        let view = ServiceView(collectionViewDataSource: self, collectionViewDelegate: self)

        return view
    }()
    
    
    //MARK: - Life cycle
    override func loadView() {
        self.view = serviceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceViewModel = ServiceViewModel(delegate: self)

        config()
        getData()
    }
}


//MARK: - Config
@available(iOS 13.0, *)
extension ServiceViewController {
    
    private func config() {
        title = "Novo serviço"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(leftHandAction))
    }
    
    
    @objc func leftHandAction() {
        self.dismiss(animated: true,completion: nil)
    }
    

}

//MARK: - API
@available(iOS 13.0, *)
extension ServiceViewController: ServiceViewModelProtocols {
    func success() {
        DispatchQueue.main.async { [self] in
            serviceView.loadResultCollectionView()
        }
    }
    
    func failure() {
        print("Error")
    }
    
    
    func getData() {
        serviceViewModel?.fetchcCursesData()
     }
}


//MARK: - Collection
@available(iOS 13.0, *)
extension ServiceViewController: UICollectionViewDataSource, UICollectionViewDelegate{
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceViewModel?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeviceViewCell.identifier, for: indexPath) as? SeviceViewCell else { return UICollectionViewCell() }
        
        cell.setupCell(cell: (serviceViewModel?.getNames(indexPath: indexPath))!)
        
        return cell
    }
    
    
    //cell selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataIndexPath = self.serviceViewModel?.getNames(indexPath: indexPath)else { return }
        
        let newService = DateSelectViewController(servico: dataIndexPath.name,
                                                  serviceIcon: dataIndexPath.icon,
                                                  servicoColor: dataIndexPath.color,
                                                  serviceDuration: dataIndexPath.duration)


        self.navigationController?.pushViewController(newService, animated: true)
    }
}
