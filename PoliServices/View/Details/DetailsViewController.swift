//
//  DetailsViewController.swift
//  PoliServices
//
//  Created by Raphael Augusto on 15/02/23.
//

import UIKit

@available(iOS 13.0, *)
class DetailsViewController: UIViewController{
 
    //MARK: - Variables
    private var alert: Alert?
    private var reasonCancel: String = ""

    
    //MARK: - ViewModel
    private var detailsViewModel: DetailsViewModel?
    
    
    //MARK: - Properts
    private lazy var detailsView: DetailsView = {
        let view = DetailsView(reasonForCancellationDataSource: self, reasonForCancellationDelegate: self)
        view.delegate = self
        view.configureTextFieldDelegate(delegate: self)

        return view
    }()
    
    
    //MARK: - life cycle
    override func loadView() {
        self.view = detailsView
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        self.detailsViewModel = DetailsViewModel(delegate: self)
        
        alertTime()
        
        config()
    }
}


//MARK: - Config
@available(iOS 13.0, *)
extension DetailsViewController {
    
    private func config() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(leftHandAction))
        
        createDismissKeyboardTapGesture()
        setupKeyboardHiding()
        
        getData()
        
        setupUIDetails()
    }
    
    //Action leftBarButton
    @objc func leftHandAction() {
        self.dismiss(animated: true,completion: nil)
    }

    
    private func alertTime() {
        self.alert?.getAlert(title: "Atenção", message: "O botão irá ficar ativo para o cancelamento caso o horário restante seja maior que 2 horas.")
    }
    
    
    private func setupUIDetails() {
        detailsViewModel?.setupRemove()
    }
}


//MARK: - Action Gesture Keyboard
@available(iOS 13.0, *)
extension DetailsViewController {
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 1.3) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}


//MARK: - UITextField
@available(iOS 13.0, *)
extension DetailsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textFieldText = textField.text else { return false }
        self.reasonCancel = textFieldText
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 100
    }
}



//MARK: - UIPicker
@available(iOS 13.0, *)
extension  DetailsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Defina o número de colunas em cada componente
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // Defina o número de linhas em cada componente
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return detailsViewModel?.count ?? 0
    }
    
    
    // Defina o título de cada linha
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return detailsViewModel?.dataValueRow(row: row)
    }
    
    
    // Defina o tamanho de cada linha
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Obtém o item selecionado na linha especificada
        let selectedValue =  detailsViewModel?.dataValueRow(row: row)
        
        if selectedValue == "Outro" {
            self.alert?.getAlert(title: "Atenção", message: "Para essa opção é obrigatório preenchar o campo a baixo.")
            detailsViewModel?.postCancelOrder(reason: reasonCancel)
            detailsView.configureButtonEnable(false)
            
        } else {
            detailsViewModel?.postCancelOrder(reason: selectedValue!)
        }
    }
}


//MARK: - Action Button
@available(iOS 13.0, *)
extension DetailsViewController: DetailsViewDelegate {
    
    func cancellationRecord() {
        detailsViewModel?.removeDefaulst()
        
        self.dismiss(animated: true,completion: nil)
    }
}


//MARK: - API And ViewModel
@available(iOS 13.0, *)
extension DetailsViewController: DetailsViewModelProtocols {

    //GET
    func successGet() {
        DispatchQueue.main.async { [self] in
            self.detailsView.loadResultPickerView()
        }
    }
    
    
    func failureGet() {
        print("Error - GET")
    }
    
    func getData() {
        detailsViewModel?.fetchcCursesData()
    }
    
    
    //POST
    func successPost() {}
    
    func failurepost() {
        print("Error - POST")
    }

    
    func removeService(data: SetupCancel) {
        detailsView.setupDetails(cell: data)
        detailsView.configureButtonEnable(true)
    }
    

    func showButton() {
        detailsView.configureButtonEnable(false)
    }
}
