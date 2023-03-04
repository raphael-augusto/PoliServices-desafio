//
//  ServiceView.swift
//  PoliServices
//
//  Created by Raphael Augusto on 22/01/23.
//

import UIKit


@available(iOS 13.0, *)
final class ServiceView: UIView {
    
    //MARK: - Delegate
    
    //MARK: - Properts
    private lazy var containerColletion: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 160, height: 150)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(SeviceViewCell.self, forCellWithReuseIdentifier: SeviceViewCell.identifier)
        collectionView.backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 234/255, alpha: 1.0)
        
        return collectionView
    }()
    
    
    //MARK: - Inits
    init(collectionViewDataSource: UICollectionViewDataSource, collectionViewDelegate: UICollectionViewDelegate) {
        super.init(frame: .zero)
        containerColletion.dataSource = collectionViewDataSource
        containerColletion.delegate = collectionViewDelegate
        
        setup()
        loadResultCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        initLayout()
    }
    
    
    func loadResultCollectionView() {
        self.containerColletion.reloadData()
    }
}

//MARK: - Components and Constraints
@available(iOS 13.0, *)
extension ServiceView : ConfigurableView {
    func initView() {
        backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 234/255, alpha: 1.0)
    }
    
    func initSubviews() {
        addSubview(containerColletion)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            containerColletion.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            containerColletion.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 22),
            containerColletion.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -22),
            containerColletion.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
