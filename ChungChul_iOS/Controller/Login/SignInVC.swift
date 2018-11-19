//
//  SignInVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift
import Lottie

class SignInVC: UIViewController, NetworkCallback {
    
    // UI IBOutlet Variable
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    
    let animationView = LOTAnimationView(name: "loading")
    let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    // Variable
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldDelegate()
        borderTextField()
        addTargetButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "로그인"
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.title = " "
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Sign In" {
            let mail = gsno(emailTextField.text)
            let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let path = userDir+"/keystore/\(mail).json"

            if isExistKeystoreFile(path) {
                successToLogin()
            } else {
                loadKeystoreDataFromKeychain(mail)
            }
        } else if code == "Fail To Sign In" {
            animationView.stop()
            indicatorView.removeFromSuperview()
            let msg = resultData as! String
            simpleAlert(title: "로그인 오류", msg: msg)
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인하세요.")
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension SignInVC {
    
    // Done Button Action Selector
    @objc func doneButtonAction(){
        indicatorViewSetting(indicatorView, animationView)
        let model = LoginModel(self)
        model.loginModel(email: gsno(emailTextField.text), password: gsno(passwordTextField.text))
    }
    
    fileprivate func setTextFieldDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // If there are no keystore file locally, load keystore data from iCloud Keychain and create keystore file locally
    fileprivate func loadKeystoreDataFromKeychain(_ mail: String) {
        if let keystoreData = Keychain.load(key: mail) {
            let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            FileManager.default.createFile(atPath: userDir + "/keystore"+"/\(mail).json", contents: keystoreData, attributes: nil)
            successToLogin()
        } else {
            animationView.stop()
            indicatorView.removeFromSuperview()
            simpleAlert(title: "키체인 오류", msg: "가입한 계정과 현재 iCloud 계정이 일치하지 않습니다.")
        }
    }
    
    // Check if a keystore file exists locally on the device
    fileprivate func isExistKeystoreFile(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    // Init Caver Singleton
    fileprivate func callCaverSingleton() {
        let userAddress = Address(gsno(ud.string(forKey: "wallet")))
        CaverSingleton.setUserAddress(userAddress)
        let instance: CaverSingleton = CaverSingleton.sharedInstance
        let keystoreManager = instance.keystoreMangaerInDevice()
        let caver = instance.caver
        caver.addKeystoreManager(keystoreManager)
    }
    
    // Success Login
    fileprivate func successToLogin() {
        DispatchQueue.global(qos: .utility).async {
            self.callCaverSingleton()
            DispatchQueue.main.async {
                self.animationView.stop()
                self.animationView.removeFromSuperview()
                UserDefaults.standard.setValue(self.gsno(self.passwordTextField.text), forKey: "password")
                let main = UIStoryboard(name: "Main", bundle: nil)
                let tabBarVC = main.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                UIApplication.shared.keyWindow?.rootViewController = tabBarVC
            }
        }
    }
    
    fileprivate func borderTextField(){
        emailTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))
        passwordTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))
    }
    
    fileprivate func addTargetButton() {
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
    }
}
