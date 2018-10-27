//
//  TeacherVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift

class TeacherVC: UIViewController, NetworkCallback {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var duplicateEmailLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    @IBOutlet var wrongPWLabel: UILabel!
    
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var birthLabel: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var phoneNumberLabel: UITextField!
    
    @IBOutlet var farmNameTextField: UITextField!
    @IBOutlet var farmNumberTextField: UITextField!
    @IBOutlet var farmAddressTextField: UITextField!
    @IBOutlet var farmCareerTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    
    let genderPickerView = UIPickerView()
    let datePickerView = UIDatePicker()
    let careerPickerView = UIPickerView()
    
    var genderArray = ["남자", "여자"]
    var sex = 1
    var careerArray = ["5년 이하", "5년 ~ 10년", "10년 이상"]
    var career = 1
    
    var privateKeyPath : KeystoreManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unableDoneBtn()
        duplicateEmailLabel.isHidden = true
        duplicateEmailLabel.text = ""
        wrongPWLabel.text = ""
        wrongPWLabel.isHidden = true
        textFieldDelegate()
        addTarget()
        genderPickerViewSetting()
        careerPickerViewSetting()
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
            let main = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = main.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            UIApplication.shared.keyWindow?.rootViewController = tabBarVC
            
        } else if code == "Null Value" {
            simpleAlert(title: "회원가입 오류", msg: "오류가 났다!")
        } else if code == "Internal Server Error" {
            simpleAlert(title: "회원가입 오류", msg: "오류가 났다!")
            
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

extension TeacherVC {
    
    
    func borderTextField(){
        emailTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        passwordTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        confirmTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        nameLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        birthLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        genderTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        phoneNumberLabel.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        farmNameTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        farmNumberTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        farmAddressTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
        farmCareerTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))
    }
    
    func genderPickerViewSetting(){
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.backgroundColor = UIColor.white
        genderPickerView.showsSelectionIndicator = true
    }
    
    func careerPickerViewSetting(){
        careerPickerView.delegate = self
        careerPickerView.dataSource = self
        careerPickerView.backgroundColor = UIColor.white
        careerPickerView.showsSelectionIndicator = true
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
        farmCareerTextField.inputView = careerPickerView
        farmCareerTextField.inputAccessoryView = toolBar
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
        farmNameTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        farmNumberTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        farmAddressTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        farmCareerTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
    }
    
    func textFieldDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        nameLabel.delegate = self
        birthLabel.delegate = self
        phoneNumberLabel.delegate = self
        genderTextField.delegate = self
        farmNameTextField.delegate = self
        farmNumberTextField.delegate = self
        farmAddressTextField.delegate = self
        farmCareerTextField.delegate = self
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
        farmCareerTextField.resignFirstResponder()
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
        var wallet = ""
        var privateKey = ""
        let farmAddress = gsno(farmAddressTextField.text)
        let farmNumber = gsno(farmNumberTextField.text)
        let farmName = gsno(farmNameTextField.text)
        do{
            let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
            var ks: BIP32Keystore?
            if (keystoreManager?.addresses?.count == 0) {
                let password = passwordTextField.text!
                let mnemonic = try! BIP39.generateMnemonics(bitsOfEntropy: 256)!
                let keystore = try! BIP32Keystore(mnemonics: mnemonic, password: password, mnemonicsPassword: String((password).reversed()))
                ks = keystore
                let keydata = try JSONEncoder().encode(ks?.keystoreParams)
                FileManager.default.createFile(atPath: userDir + "/keystore"+"/key.json", contents: keydata, attributes: nil)
                
                print(userDir)
                wallet = gsno(ks?.addresses![0].address)
                let path = userDir+"/keystore/"
                privateKeyPath =  KeystoreManager.managerForPath(path, scanForHDwallets: true, suffix: "json")
                let key = try privateKeyPath?.UNSAFE_getPrivateKeyData(password: password, account: ((privateKeyPath?.addresses?.first)!))
                print("pkey",key?.toHexString())
                wallet = gsno(ks?.addresses![0].address)
                privateKey = gsno(key?.toHexString())
                
                let model = JoinModel(self)
                model.joinTeacherModel(mail: mail, passwd: passwd, name: name, sex: sex, hp: hp, birth: birth, career: career, private_key: privateKey, wallet: wallet, farm_addr: farmAddress, farm_num: farmNumber, farm_name: farmName)
            } else {
                ks = keystoreManager?.walletForAddress((keystoreManager?.addresses![0])!) as? BIP32Keystore
            }
        } catch {
            print(error.localizedDescription)
        }
        
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

extension TeacherVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPickerView{
            return genderArray.count
        } else if pickerView == careerPickerView{
            return careerArray.count
        } else {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        if pickerView == genderPickerView{
            return genderArray[row]
        } else if pickerView == careerPickerView{
            return careerArray[row]
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int,inComponent component: Int) {
        if pickerView == genderPickerView{
            genderTextField.text = genderArray[row]
            switch gsno(genderTextField.text) {
            case "남자":
                sex = 1
            case "여자":
                sex = 2
            default:
                break
            }
        } else if pickerView == careerPickerView{
            farmCareerTextField.text = careerArray[row]
            switch gsno(genderTextField.text) {
            case "5년 이하":
                career = 1
            case "5년 ~ 10년":
                career = 2
            case "10년 이상":
                career = 3
            default:
                break
            }
        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == genderTextField{
            self.genderPickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(genderPickerView, didSelectRow: 0, inComponent: 0)
        } else if textField == farmCareerTextField{
            self.careerPickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(careerPickerView, didSelectRow: 0, inComponent: 0)
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
            farmNameTextField.becomeFirstResponder()
        } else if textField == farmNameTextField{
            farmNumberTextField.becomeFirstResponder()
        } else if textField == farmNumberTextField{
            farmAddressTextField.becomeFirstResponder()
        } else if textField == farmAddressTextField{
            farmCareerTextField.becomeFirstResponder()
        } else if textField == farmCareerTextField{
            textField.resignFirstResponder()
        }
        return true
    }
}
