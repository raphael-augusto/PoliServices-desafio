//
//  SeviceViewCell.swift
//  PoliServices
//
//  Created by Raphael Augusto on 23/01/23.
//

import UIKit


@available(iOS 13.0, *)
final class SeviceViewCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static let identifier:String = "SeviceViewCell"
    
    
    //MARK: - Properts
    private lazy var stackViewContainer: UIStackView = {
        let stackView = UIStackView( arrangedSubviews: [
            serviceDescriptionImage,
            serviceDescriptionLabel,
            durationLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis      = .vertical
        stackView.spacing   = .zero
        stackView.alignment = .center
        
        return stackView
    }()
    
    
    private lazy var serviceDescriptionImage: UIImageView = {
        let img   = UIImage(systemName: "arrow.clockwise.icloud.fill")
        let image = UIImageView(image: img)
        image.tintColor = .systemBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var serviceDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.text = "Código"
        
        return lb
    }()
    
    private lazy var durationLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.text = "Duração: 00:00"
        
        return lb
    }()

    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func setup() {
        initLayout()
    }
    
    
    public func setupCell(cell: ServiceData) {
        let img           = UIImage(systemName: cell.icon)
        let color         = UIColor(hexString: cell.color).cgColor
        let formattedTime = String.formatTime(totalMinutes: cell.duration)
        
        
        self.serviceDescriptionImage.image      = img
        self.serviceDescriptionLabel.text       = cell.name
        self.serviceDescriptionImage.tintColor  = UIColor(cgColor: color)
        self.durationLabel.text                 = "Duração: \(formattedTime)h"
    }
    
}

//MARK: - Components and Constraints
@available(iOS 13.0, *)
extension SeviceViewCell : ConfigurableView {
    func initView() {
        backgroundColor     = .white
        layer.cornerRadius  = 10
    }
    
    func initSubviews() {
        addSubview(stackViewContainer)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            serviceDescriptionImage.widthAnchor.constraint(equalToConstant: 70),
            serviceDescriptionImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
}




