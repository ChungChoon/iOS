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
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borderTextField()
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
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
            let main = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = main.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            UIApplication.shared.keyWindow?.rootViewController = tabBarVC
            
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
    
    func borderTextField(){
        emailTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))
        passwordTextField.addBorderBottom(height: 1.0, color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))
    }
    
    @objc func doneButtonAction(){
        let model = LoginModel(self)
        model.loginModel(email: gsno(emailTextField.text), password: gsno(passwordTextField.text))
    }
    
}
