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
    var servico: String?
    var datePicker: String?
    
    
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
    
    init(servico: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.servico = servico
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightHandAction))
    }
    
    
    @objc func rightHandAction() {
        UserDefaults.standard.set(datePicker, forKey: "service_date")
        UserDefaults.standard.set(servico, forKey: "service_name")
        
        self.dismiss(animated: true,completion: nil)
    }
}


//MARK: - Action
@available(iOS 13.0, *)
extension DateSelectViewController: DateSelectViewDelegate {
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        datePicker = selectedDate
    }
}
