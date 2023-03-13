//
//  DateSelectViewController.swift
//  PoliServices
//
//  Created by Raphael Augusto on 24/01/23.
//

import UIKit


@available(iOS 13.0, *)
class DateSelectViewController: UIViewController {

    //MARK: - Variable
    var servico: String
    var serviceIcon: String
    var servicoColor: String
    var serviceDuration: Int
    var datePicker: String?
    
    
    //MARK: - ViewModel
    private var dateSelectViewModel = DateSelectViewModel()
    
    
    //MARK: - Properts
    private lazy var dateSelectView: DateSelectView = {
        let view = DateSelectView()
        view.delegate = self

        return view
    }()
    
    
    //MARK: - Inits
    override func loadView() {
        self.view = dateSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    init(
        servico: String,
        serviceIcon: String,
        servicoColor: String,
        serviceDuration: Int
        
    ) {
        self.servico         = servico
        self.serviceIcon     = serviceIcon
        self.servicoColor    = servicoColor
        self.serviceDuration = serviceDuration

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Config
@available(iOS 13.0, *)
extension DateSelectViewController {
    
    private func config() {
        title = "Novo serviço"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightHandAction))
    }
    
    
    @objc func rightHandAction() {
        dateSelectViewModel.userDefaults(addDefaults: DefaultsName.init(datePicker: self.datePicker ?? "",
                                                                        servico: self.servico ,
                                                                        serviceIcon: self.serviceIcon ,
                                                                        servicoColor: self.servicoColor ))
        
        self.dismiss(animated: true,completion: nil)
    }
}


//MARK: - Action
@available(iOS 13.0, *)
extension DateSelectViewController: DateSelectViewDelegate {
        
    func datePickerValueChanged(_ sender: UIDatePicker) {
        // Create date formatter
        let formatter = DateFormatter()
        
        // Set date format
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
                
        // Apply date format and hour
        var selectedDate = sender.date
        selectedDate = selectedDate.addingTimeInterval(Double(serviceDuration) * 60)
        
        let addedTimeString = formatter.string(from: selectedDate)
        
        datePicker = addedTimeString
    }
}
