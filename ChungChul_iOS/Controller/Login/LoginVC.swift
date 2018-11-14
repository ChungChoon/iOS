//
//  LoginVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 17/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift

class LoginVC: UIViewController {

    // UI IBOutlet Variable
    @IBOutlet var loginbutton: UIButton!
    @IBOutlet var joinButton: UIButton!
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        addTargetButton()
    }
}

extension LoginVC {
    
    // Login Button Action Selector
    @objc func loginButtonAction() {
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") else { return }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    // Join Button Action Selector
    @objc func joinButtonAction() {
        guard let joinVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") else { return }
        self.navigationController?.pushViewController(joinVC, animated: true)
    }
    
    fileprivate func navigationBarSetting(){
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Bold", size: 24)!]
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_arrow_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_arrow_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    fileprivate func addTargetButton() {
        loginbutton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        joinButton.addTarget(self, action: #selector(joinButtonAction), for: .touchUpInside)
    }
    
}
