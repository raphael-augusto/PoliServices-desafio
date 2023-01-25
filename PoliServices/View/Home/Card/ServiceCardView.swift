//
//  ServiceCardView.swift
//  PoliServices
//
//  Created by Raphael Augusto on 21/01/23.
//

import UIKit


@available(iOS 13.0, *)
final class ServiceCardView: UIView {
    
    //MARK: - Delegate
    
    //MARK: - Properts
    private lazy var cardLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "Nome do serviço"
        lb.textColor = .white
        
        return lb
    }()
    
    
    private lazy var stackViewContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            stackViewDescriptionDate,
            ImageCardLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .lastBaseline
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    
    private lazy var stackViewDescriptionDate: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            descriptionDateCardLabel,
            DateAndHourCardLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var descriptionDateCardLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.text = "Data e hora"
        lb.textColor = .white
        
        return lb
    }()
    
    private lazy var DateAndHourCardLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.numberOfLines = 9
        lb.text = "30/11 as 19h"
        lb.textColor = .white
        
        return lb
    }()
    
    private lazy var ImageCardLabel: UIImageView = {
        let img  = UIImage(systemName: "book.fill")
        let imgv = UIImageView(image: img)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.tintColor = .white
        
        return imgv
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
    
    
    //MARK: - Func Config
    public func setupCardService(nameServiceText: String, dateAndHourText: String){
        cardLabel.text              = nameServiceText
        DateAndHourCardLabel.text   = dateAndHourText
    }
}

//MARK: - Components and Constraints
@available(iOS 13.0, *)
extension ServiceCardView: ConfigurableView {
    func initView() {
        backgroundColor     =  UIColor(red: 52/255, green: 176/255, blue: 197/255, alpha: 1.0)
        layer.cornerRadius  = 10
    }
    
    func initSubviews() {
        addSubview(cardLabel)
        addSubview(stackViewContainer)
        
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            cardLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cardLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            stackViewContainer.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 27),
            stackViewContainer.leftAnchor.constraint(equalTo: cardLabel.leftAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            ImageCardLabel.widthAnchor.constraint(equalToConstant: 71),
            ImageCardLabel.heightAnchor.constraint(equalToConstant: 68),
        ])
    }
    
    
}


