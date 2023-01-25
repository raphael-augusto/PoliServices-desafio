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
    private var serviceViewModel = ServiceViewModel()
    
    
    
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
        
        config()
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


//MARK: - Collection
@available(iOS 13.0, *)
extension ServiceViewController: UICollectionViewDataSource, UICollectionViewDelegate{
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceViewModel.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeviceViewCell.identifier, for: indexPath) as? SeviceViewCell else { return UICollectionViewCell() }
        
        cell.setupCell(cell: serviceViewModel.getNames(indexPath: indexPath) as! ServiceData)

        
        switch indexPath.row {
        case 0:
            cell.setupImagetintColor(color: "cyan", icon: "pencil.slash")
        case 1:
            cell.setupImagetintColor(color: "green", icon: "graduationcap.circle.fill")
        case 2:
            cell.setupImagetintColor(color: "pink", icon: "books.vertical.fill")
        case 3:
            cell.setupImagetintColor(color: "brown", icon: "scribble.variable")
        default:
            break
        }

        return cell
    }
    
    //cell selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataIndexPath = self.serviceViewModel.getNames(indexPath: indexPath).descriptionName else { return }

        switch indexPath.row {
        case 0:
            print(dataIndexPath)
            let newService = DateSelectViewController(servico: dataIndexPath)
            self.navigationController?.pushViewController(newService, animated: true)
            
        case 1:
            print(dataIndexPath)
            let newService = DateSelectViewController(servico: dataIndexPath)
            self.navigationController?.pushViewController(newService, animated: true)
            
        case 2:
            print(dataIndexPath)
            let newService = DateSelectViewController(servico: dataIndexPath)
            self.navigationController?.pushViewController(newService, animated: true)
            
        case 3:
            print(dataIndexPath)
            let newService = DateSelectViewController(servico: dataIndexPath)
            self.navigationController?.pushViewController(newService, animated: true)
            
        default:
            break
        }
    }
}



