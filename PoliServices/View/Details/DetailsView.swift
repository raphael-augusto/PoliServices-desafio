//
//  DetailsView.swift
//  PoliServices
//
//  Created by Raphael Augusto on 15/02/23.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func cancellationRecord ()
}

@available(iOS 13.0, *)
final class DetailsView: UIView {
    
    //MARK: - Delegate
    weak var delegate: DetailsViewDelegate?
        
    
    //MARK: - Properts
    private lazy var serviceInformationLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 29)
        lb.text = "Informações do serviço"
        lb.textColor = .black
        
        return lb
    }()
    
    //MARK: - stackViewServiceContainer
    private lazy var stackViewServiceContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageService,
            nameServiceLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        return stackView
    }()
        
    private lazy var nameServiceLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "Nome do serviço"
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var imageService: UIImageView = {
        let img  = UIImage(systemName: "book.fill")
        let imgv = UIImageView(image: img)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.tintColor = .black
        
        return imgv
    }()
    
    
    //MARK: - stackViewServiceDateContainer
    private lazy var stackViewServiceDateContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            startDateLabel,
            startTimeLabel,
            closingDateLabel,
            closingTimeLabel,
            creationDateLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var startDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.numberOfLines = 9
        lb.text = "Data de início: 03 de janeiro de 2023"
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var startTimeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.numberOfLines = 9
        lb.text = "Hora de início: 11:00 AM"
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var closingDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.numberOfLines = 9
        lb.text = "Data de encerramento: 03 de janeiro de 2023"
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var closingTimeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.numberOfLines = 9
        lb.text = "Hora de encerramento: 11:00 AM"
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var creationDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.numberOfLines = 9
        lb.text = "Data de criação: 03 de janeiro de 2023"
        lb.textColor = .black
        
        return lb
    }()
    
    
    //MARK: - stackViewContainercancellation
    private lazy var stackViewContainerCancellation: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            stackViewContainerCancellationInformation,
            reasonForCancellationTextField,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var stackViewContainerCancellationInformation: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cancellationInformationLabel,
//            cancellatioLabel,
            optionCancellatioLabel,
            reasonForCancellationPickerView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6
        
        return stackView
    }()
    
    
    private lazy var cancellationInformationLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.numberOfLines = 9
        lb.text = "Informações de cancelamento"
        lb.textColor = .black
        
        return lb
    }()
    
    
    private lazy var optionCancellatioLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lb.numberOfLines = 9
        lb.text = "Escolha a opção que deseja fazer o cancelamento:"
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var reasonForCancellationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        return pickerView
    }()
    
    private lazy var reasonForCancellationTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.font = .systemFont(ofSize: 20, weight: .regular)
        tf.keyboardType = .default
        tf.textAlignment = .left
        tf.contentVerticalAlignment = .top
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.clipsToBounds = true
        tf.returnKeyType = .done
        
        return tf
    }()
    
    
    private lazy var serviceButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Cancelamento", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        bt.setTitleColor(.lightGray, for: .normal)
        bt.backgroundColor = UIColor(red: 184/255, green: 206/255, blue: 237/255, alpha: 1)
        bt.layer.cornerRadius = 30
        bt.isEnabled = false
        
        bt.addTarget(self, action: #selector(cancellationRecord), for: .touchUpInside)
        
        return bt
    }()
    
    //MARK: - Inits
    init(reasonForCancellationDataSource: UIPickerViewDataSource, reasonForCancellationDelegate: UIPickerViewDelegate) {
        super.init(frame: .zero)
        reasonForCancellationPickerView.dataSource = reasonForCancellationDataSource
        reasonForCancellationPickerView.delegate = reasonForCancellationDelegate
        
        setup()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        initLayout()
    }
    
    
    public func configureTextFieldDelegate(delegate:UITextFieldDelegate) {
        self.reasonForCancellationTextField.delegate     = delegate
    }
    
    
    func configureButtonEnable(_ enable:Bool) {
        if enable {
            self.serviceButton.setTitleColor(.blue, for: .normal)
            self.serviceButton.isEnabled = true
        } else {
            self.serviceButton.setTitleColor(.lightGray, for: .normal)
            self.serviceButton.isEnabled = false
        }
    }
    
    
    func loadResultPickerView() {
        self.reasonForCancellationPickerView.reloadAllComponents()
    }

    
    public func setupDetails(cell: SetupCancel) {
        let img       = UIImage(systemName: cell.serviceIcon)
        let colorData = UIColor(hexString: cell.serviceColor).cgColor
        
        imageService.image      = img
        imageService.tintColor  = UIColor(cgColor: colorData)
        nameServiceLabel.text   = cell.serviceName
        startDateLabel.text     = "Data de início: \(cell.createDate)"
        startTimeLabel.text     = "Hora de início: \(cell.startTime)"
        closingDateLabel.text   = "Data de encerramento: \(cell.closingDate)"
        closingTimeLabel.text   = "Hora de encerramento: \(cell.closingTime)"
        creationDateLabel.text  = "Data de criação: \(cell.createDate)"
    }
}

//MARK: - Components and Constraints
@available(iOS 13.0, *)
extension DetailsView : ConfigurableView {
    
    func initView() {
        backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 234/255, alpha: 1.0)
    }
    
    func initSubviews() {
        addSubview(serviceInformationLabel)
        addSubview(stackViewServiceContainer)
        addSubview(stackViewServiceDateContainer)
        addSubview(stackViewContainerCancellation)
        addSubview(serviceButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            serviceInformationLabel.topAnchor.constraint(equalTo:  safeAreaLayoutGuide.topAnchor, constant: 15),
            serviceInformationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 22),
            serviceInformationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -22),
            
            
            stackViewServiceContainer.topAnchor.constraint(equalTo: serviceInformationLabel.bottomAnchor, constant: 27),
            stackViewServiceContainer.leadingAnchor.constraint(equalTo: serviceInformationLabel.leadingAnchor),
            
            
            imageService.widthAnchor.constraint(equalToConstant: 71),
            imageService.heightAnchor.constraint(equalToConstant: 68),
            
            
            stackViewServiceDateContainer.topAnchor.constraint(equalTo: stackViewServiceContainer.bottomAnchor, constant: 27),
            stackViewServiceDateContainer.leadingAnchor.constraint(equalTo: serviceInformationLabel.leadingAnchor),
            stackViewServiceDateContainer.trailingAnchor.constraint(equalTo: serviceInformationLabel.trailingAnchor),
            
            
            stackViewContainerCancellation.topAnchor.constraint(equalTo: stackViewServiceDateContainer.bottomAnchor, constant: 27),
            stackViewContainerCancellation.leadingAnchor.constraint(equalTo: serviceInformationLabel.leadingAnchor),
            stackViewContainerCancellation.trailingAnchor.constraint(equalTo: serviceInformationLabel.trailingAnchor),
            
            
            reasonForCancellationPickerView.heightAnchor.constraint(equalToConstant: 120),
            
            
            reasonForCancellationTextField.heightAnchor.constraint(equalToConstant: 100),
            
            
            serviceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            serviceButton.heightAnchor.constraint(equalToConstant: 55),
            serviceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            serviceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
        ])
    }
}


//MARK: - Action
@available(iOS 13.0, *)
extension DetailsView: DetailsViewDelegate {
    
    @objc func cancellationRecord() {
        self.delegate?.cancellationRecord()
    }
}

