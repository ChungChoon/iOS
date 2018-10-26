//
//  LoginVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 17/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginbutton: UIButton!
    @IBOutlet var joinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginbutton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        joinButton.addTarget(self, action: #selector(joinButtonAction), for: .touchUpInside)
    }

}

extension LoginVC {
    
    @objc func loginButtonAction() {
        
    }
    
    @objc func joinButtonAction() {
        guard let joinVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") else { return }
        self.navigationController?.pushViewController(joinVC, animated: true)
    }
    
}
