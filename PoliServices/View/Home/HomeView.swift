//
//  HomeView.swift
//  PoliServices
//
//  Created by Raphael Augusto on 16/01/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func newService ()
}


@available(iOS 13.0, *)
final class  HomeView : UIView {
    
    //MARK: - Delegate
    weak var delegate: HomeViewDelegate?
    
    
    //MARK: - Properts
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 32)
        lb.text = "Bem-Vindo ao DevServices"
        lb.numberOfLines = 2

        return lb
    }()
    
    private lazy var dateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = .darkGray
        lb.text = "30 de novembro de 2022"

        return lb
    }()
    
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        return view
    }()
    
    private lazy var aboutUsLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.text = "Sobre nós"
        
        return lb
    }()
    
    
    private lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.numberOfLines = 9
        lb.text = "A DevServices é o melhor aplicativo para reservar seu agendamento com serviços. Aqui é um espaço que você consegue reservar um espaço na minha agenda e vamos resolver suas dúvidas.\nSelecione o tipo de atendimento e vamos pra cima!\n\n*Ilustrativo"
        
        return lb
    }()
    
    private lazy var chevronView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemIndigo
        
        return view
    }()
    
    
    
    private lazy var containertStackView: UIStackView = {
        let stackView = UIStackView( arrangedSubviews: [
            cardServiceStackView,
            serviceButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10

        return stackView
    }()

    
    
    private lazy var cardServiceStackView: UIView = {
        let stackView = UIStackView( arrangedSubviews: [
            containerServiceStackView,
            serviceCardView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
         stackView.isHidden = true
        
        return stackView
    }()
    
    
    private lazy var containerServiceStackView: UIView = {
        let stackView = UIStackView( arrangedSubviews: [
            nextServiceLabel,
            timeLeftToCompleteServiceLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    
    private lazy var nextServiceLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.text = "Próximo Serviço"
        
        return lb
    }()
    
    private lazy var timeLeftToCompleteServiceLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.text = "Tempo de para finalizar"
        
        return lb
    }()
    
    
    lazy var serviceCardView: ServiceCardView = {
        let view = ServiceCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    private lazy var serviceButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Solicitar novo serviço", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        bt.setTitleColor(.blue, for: .normal)
        bt.backgroundColor = UIColor(red: 184/255, green: 206/255, blue: 237/255, alpha: 1)
        bt.layer.cornerRadius = 30
        
        bt.addTarget(self, action: #selector(newService), for: .touchUpInside)
        
        return bt
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
    public func cardServiceIsHidden(active: Bool) {
        cardServiceStackView.isHidden = active
        cardServiceStackView.alpha    = active ? 0 : 1
    }
    
    
    public func serviceButtonIsHidden(active: Bool) {
        serviceButton.isHidden = active
        serviceButton.alpha    = active ? 0 : 1
    }
    
    
    public func ToCompleteService(textTime: String) {
        timeLeftToCompleteServiceLabel.text = textTime
    }
}



//MARK: - Components and Constraints
@available(iOS 13.0, *)
extension HomeView: ConfigurableView {
    func initView() {
        backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 234/255, alpha: 1.0)
    }
    
    func initSubviews() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(descriptionView)
        descriptionView.addSubview(aboutUsLabel)
        descriptionView.addSubview(descriptionLabel)
        addSubview(chevronView)
        addSubview(containertStackView)

    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -22),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 22),
            
            descriptionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 32),
            descriptionView.heightAnchor.constraint(equalToConstant: 196),
            descriptionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            descriptionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            aboutUsLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 12),
            aboutUsLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            aboutUsLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),

            descriptionLabel.topAnchor.constraint(equalTo: aboutUsLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -12),

            chevronView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 32),
            chevronView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 55),
            chevronView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -55),
            chevronView.heightAnchor.constraint(equalToConstant: 1),
            
            containertStackView.topAnchor.constraint(equalTo: chevronView.bottomAnchor, constant: 32),
            containertStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            containertStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            
            serviceButton.heightAnchor.constraint(equalToConstant: 55),
            serviceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            serviceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
        ])
    }
}


//MARK: - Action
@available(iOS 13.0, *)
extension  HomeView : HomeViewDelegate {
    
    @objc func newService() {
        self.delegate?.newService()
    }
}

