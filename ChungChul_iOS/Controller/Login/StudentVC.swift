//
//  StudentVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift

class StudentVC: UIViewController, NetworkCallback {

    // UI IBOutlet Variable
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
    
    // PickerView Variable
    let genderPickerView = UIPickerView()
    let datePickerView = UIDatePicker()
    
    // Variable
    var genderArray = ["남자", "여자"]
    var sex = 1
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializingUISetting()
        textFieldDelegate()
        addTarget()
        genderPickerViewSetting()
        borderTextFieldSetting()
        unableDoneBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "회원가입"
        pickerViewToolBarSetting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.title = " "
    }
    
    func networkResult(resultData: Any, code: String) {
        // Login Network Response
        if code == "Success To Sign Up" {
            performSegue(withIdentifier: "unwindToLogin", sender: self)
        } else if code == "Null Value" {
            simpleAlert(title: "회원가입 오류", msg: "오류가 났다!")
        } else if code == "Internal Server Error" {
            simpleAlert(title: "회원가입 오류", msg: "오류가 났다!")
        }
        
        // Duplicate Email Response
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
        datePickerView.addTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
    }
}

extension StudentVC {
    
    @objc func doneButtonAction() {
        let mail = gsno(emailTextField.text)
        let passwd = gsno(confirmTextField.text)
        let name = gsno(nameLabel.text)
        let hp = gsno(phoneNumberLabel.text)
        let birth = gsno(birthLabel.text)
        createAccount(passwd, mail, name, hp, birth)
    }
    
    @objc func duplicateEmailAction(_ sender: UITextField) {
        let model = JoinModel(self)
        if sender == emailTextField{
            let email = gsno(sender.text)
            model.duplicateEmailModel(mail: email)
        }
        isValid()
    }
    
    @objc func setPickerResponderAction() {
        genderTextField.resignFirstResponder()
        birthLabel.resignFirstResponder()
    }
    
    @objc func valueChangedAction(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthLabel.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func passwordCompareAction(){
        if passwordTextField.text != confirmTextField.text {
            passwordUISetting("잘못된 비밀번호입니다.", false, #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        } else {
            passwordUISetting("", true, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        }
    }
    
    fileprivate func initializingUISetting() {
        duplicateEmailLabel.isHidden = true
        duplicateEmailLabel.text = ""
        wrongPWLabel.text = ""
        wrongPWLabel.isHidden = true
    }
    
    
    fileprivate func borderTextFieldSetting(){
        emailTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        passwordTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        confirmTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        nameLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        birthLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        genderTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        phoneNumberLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
    }
    
    fileprivate func genderPickerViewSetting(){
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.backgroundColor = UIColor.white
        genderPickerView.showsSelectionIndicator = true
    }
    
    fileprivate func pickerViewToolBarSetting(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "확인", style: UIBarButtonItem.Style.done, target: self, action: #selector(setPickerResponderAction))
        let cancelButton = UIBarButtonItem(title: "취소", style: UIBarButtonItem.Style.plain, target: self, action: #selector(setPickerResponderAction))
        
        toolBar.setItems([cancelButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        birthLabel.inputAccessoryView = toolBar
        genderTextField.inputView = genderPickerView
        genderTextField.inputAccessoryView = toolBar
    }
    
    fileprivate func addTarget(){
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(duplicateEmailAction), for: .editingDidEnd)
        confirmTextField.addTarget(self, action: #selector(passwordCompareAction), for: .editingChanged)
        addTargetIsVaild()
    }
    
    fileprivate func addTargetIsVaild(){
        emailTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        confirmTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        nameLabel.addTarget(self, action: #selector(isValid), for: .editingChanged)
        birthLabel.addTarget(self, action: #selector(isValid), for: .editingChanged)
        phoneNumberLabel.addTarget(self, action: #selector(isValid), for: .editingChanged)
        genderTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
    }
    
    fileprivate func textFieldDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        nameLabel.delegate = self
        birthLabel.delegate = self
        phoneNumberLabel.delegate = self
        genderTextField.delegate = self
    }
    
    fileprivate func passwordUISetting(_ text: String, _ isHidden: Bool, _ textColor: UIColor) {
        wrongPWLabel.text = text
        wrongPWLabel.isHidden = isHidden
        confirmTextField.textColor = textColor
    }
    
    fileprivate func isEmpty(_ sender: [UITextField]) -> Bool {
        var check: Bool = true
        for textField in sender{
            if textField.text?.isEmpty == true {
                check = true
                break
            } else {
                check = false
            }
        }
        if check == true{
            return true
        } else {
            return false
        }
    }
    
    @objc func isValid(){
        let textFieldArray = [emailTextField,passwordTextField,confirmTextField,nameLabel,birthLabel,phoneNumberLabel,genderTextField]
        if !(isEmpty(textFieldArray as! [UITextField]) || duplicateEmailLabel.text == "중복된 이메일 입니다." || wrongPWLabel.text == "잘못된 비밀번호입니다.") {
            enableDoneBtn()
        } else {
            unableDoneBtn()
        }
    }
    
    fileprivate func unableDoneBtn(){
        doneButton.isEnabled = false
        doneButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    fileprivate func enableDoneBtn(){
        doneButton.isEnabled = true
        doneButton.backgroundColor = #colorLiteral(red: 0.388343066, green: 0.5422144532, blue: 0.9160783887, alpha: 1)
    }
    
    fileprivate func createAccount(_ passwd: String, _ mail: String, _ name: String, _ hp: String, _ birth: String) {
        do{
            // Create Keystore File in Local Device
            let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            var keystore: EthereumKeystoreV3?
            keystore = try EthereumKeystoreV3(password: passwd, aesMode: "aes-128-ctr")
            let keydata = try JSONEncoder().encode(keystore!.keystoreParams)
            FileManager.default.createFile(atPath: userDir + "/keystore"+"/\(mail).json", contents: keydata, attributes: nil)
            let wallet = gsno(keystore?.getAddress()?.address)
            let keyDataToString = gsno(String(data: keydata, encoding: .utf8))
            
            // Request Join by student
            let model = JoinModel(self)
            model.joinStudentModel(mail: mail, passwd: passwd, name: name, sex: sex, hp: hp, birth: birth, key: keyDataToString, wallet: wallet)
        } catch {
            print(error.localizedDescription)
            simpleAlert(title: "회원가입 오류", msg: "개발자에게 문의하세요.")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
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
}
