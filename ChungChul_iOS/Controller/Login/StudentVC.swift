//
//  StudentVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class StudentVC: UIViewController, NetworkCallback {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var duplicateEmailLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    @IBOutlet var wrongPWLabel: UILabel!
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var birthLabel: UITextField!
    @IBOutlet var phoneNumberLabel: UITextField!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var genderTextField: UITextField!
    
    let genderPickerView = UIPickerView()
    let datePickerView = UIDatePicker()
    
    var genderArray = ["남자", "여자"]
    var sex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        duplicateEmailLabel.isHidden = true
        duplicateEmailLabel.text = ""
        wrongPWLabel.text = ""
        wrongPWLabel.isHidden = true
        textFieldDelegate()
        addTarget()
        genderPickerViewSetting()
        borderTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "회원가입"
        pickerViewToolBarSetting()
    }
    
    func networkResult(resultData: Any, code: String) {
        print(code)
        if code == "Success To Sign Up" {
            
        } else if code == "Null Value" {
            
        } else if code == "Internal Server Error" {
            
        }
        
        if code == "duplication" {
            duplicateEmailLabel.isHidden = false
            duplicateEmailLabel.text = "중복된 이메일 입니다."
        } else if code == "available" {
            duplicateEmailLabel.isHidden = true
            duplicateEmailLabel.text = ""
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }
    
    @IBAction func birthPickerEditing(_ sender: UITextField) {
        datePickerView.backgroundColor = UIColor.white
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
        datePickerView.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }

    
}

extension StudentVC {
    
    
    func borderTextField(){
        emailTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        passwordTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        confirmTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        nameLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        birthLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        genderTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        phoneNumberLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
    }
    
    func genderPickerViewSetting(){
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.backgroundColor = UIColor.white
        genderPickerView.showsSelectionIndicator = true
    }
    
    func pickerViewToolBarSetting(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePicker))
        let cancelButton = UIBarButtonItem(title: "취소", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
        
        toolBar.setItems([cancelButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        birthLabel.inputAccessoryView = toolBar
        genderTextField.inputView = genderPickerView
        genderTextField.inputAccessoryView = toolBar
    }
    
    func addTarget(){
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(duplicateEmail), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        confirmTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        confirmTextField.addTarget(self, action: #selector(passwordCompareAction), for: .editingChanged)
        nameLabel.addTarget(self, action: #selector(isValid), for: .editingChanged)
        birthLabel.addTarget(self, action: #selector(isValid), for: .editingChanged)
        phoneNumberLabel.addTarget(self, action: #selector(isValid), for: .editingChanged)
        genderTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
    }
    
    func textFieldDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        nameLabel.delegate = self
        birthLabel.delegate = self
        phoneNumberLabel.delegate = self
        genderTextField.delegate = self
    }
    
    @objc func passwordCompareAction(){
        if passwordTextField.text != confirmTextField.text {
            wrongPWLabel.text = "잘못된 비밀번호입니다."
            wrongPWLabel.isHidden = false
            confirmTextField.textColor = UIColor.red
        } else {
            wrongPWLabel.text = ""
            wrongPWLabel.isHidden = true
            confirmTextField.textColor = UIColor.black
        }
    }
    
    @objc func isValid(){
        if !((emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (confirmTextField.text?.isEmpty)! ||  (nameLabel.text?.isEmpty)! || (birthLabel.text?.isEmpty)! || (phoneNumberLabel.text?.isEmpty)! || (genderTextField.text?.isEmpty)! || duplicateEmailLabel.text == "중복된 이메일 입니다." || wrongPWLabel.text == "잘못된 비밀번호입니다.") {
            enableDoneBtn()
        }
        else {
            unableDoneBtn()
        }
    }
    
    @objc func duplicateEmail(_ sender: UITextField) {
        let model = JoinModel(self)
        if sender == emailTextField{
            let email = gsno(sender.text)
            model.duplicateEmailModel(mail: email)
        }
        isValid()
    }
    
    @objc func donePicker() {
        genderTextField.resignFirstResponder()
        birthLabel.resignFirstResponder()
    }
    
    func unableDoneBtn(){
        self.doneButton.isEnabled = false
    }
    func enableDoneBtn(){
        self.doneButton.isEnabled = true
    }
    
    @objc func doneButtonAction() {
        let mail = gsno(emailTextField.text)
        let passwd = gsno(confirmTextField.text)
        let name = gsno(nameLabel.text)
        let hp = gsno(phoneNumberLabel.text)
        let birth = gsno(birthLabel.text)
        
        let model = JoinModel(self)
        model.joinStudentModel(mail: mail, passwd: passwd, name: name, sex: sex, hp: hp, birth: birth, private_key: "", wallet: "")
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthLabel.text = dateFormatter.string(from: sender.date)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

extension StudentVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        return genderArray[row]
    }
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int,inComponent component: Int) {
        genderTextField.text = genderArray[row]
        switch gsno(genderTextField.text) {
        case "남자":
            sex = 1
        case "여자":
            sex = 2
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == genderTextField{
            self.genderPickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(genderPickerView, didSelectRow: 0, inComponent: 0)
        }
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmTextField.becomeFirstResponder()
        } else if textField == confirmTextField{
            nameLabel.becomeFirstResponder()
        } else if textField == nameLabel{
            birthLabel.becomeFirstResponder()
        } else if textField == birthLabel{
            genderTextField.becomeFirstResponder()
        } else if textField == genderTextField{
            phoneNumberLabel.becomeFirstResponder()
        } else if textField == phoneNumberLabel{
            textField.resignFirstResponder()
        }
        return true
    }
}
