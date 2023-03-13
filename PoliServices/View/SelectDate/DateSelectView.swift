//
//  DateSelectView.swift
//  PoliServices
//
//  Created by Raphael Augusto on 24/01/23.
//

import UIKit

protocol DateSelectViewDelegate: AnyObject {
    func datePickerValueChanged(_ sender: UIDatePicker)
    
}


@available(iOS 13.0, *)
final class DateSelectView: UIView {
    
    //MARK: - Delegate
    weak var delegate: DateSelectViewDelegate?
    
    
    //MARK: - Properts
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 32)
        lb.text = "Selecione a data e hora para reservar"
        lb.numberOfLines = 2

        return lb
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        datePicker.locale = Locale(identifier: "pt_BR")
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 1
        datePicker.contentMode = .scaleToFill
        datePicker.minimumDate = Date()
        datePicker.date = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? Date()
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return datePicker
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
}

//MARK: - Components and Constraints
@available(iOS 13.0, *)
extension DateSelectView : ConfigurableView {
    func initView() {
        backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 234/255, alpha: 1.0)
    }
    
    func initSubviews() {
        addSubview(titleLabel)
        addSubview(datePicker)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            datePicker.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
}


@available(iOS 13.0, *)
extension DateSelectView: DateSelectViewDelegate {
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        self.delegate?.datePickerValueChanged(sender)
    }
}
