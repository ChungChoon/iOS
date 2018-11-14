//
//  SignInVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift

class SignInVC: UIViewController, NetworkCallback {
    
    // UI IBOutlet Variable
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    
    // Variable
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                simpleAlert(title: "지갑 오류", msg: "아이폰 내부에 지갑이 존재하지 않습니다!")
            }
        } else if code == "Fail To Sign In" {
            let msg = resultData as! String
            simpleAlert(title: "로그인 오류", msg: msg)
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인하세요.")
    }
}

extension SignInVC {
    
    // Done Button Action Selector
    @objc func doneButtonAction(){
        let model = LoginModel(self)
        model.loginModel(email: gsno(emailTextField.text), password: gsno(passwordTextField.text))
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
