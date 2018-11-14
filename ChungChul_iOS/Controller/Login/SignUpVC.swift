//
//  SignUpVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 17/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    // UI IBOutlet Variable
    @IBOutlet var studentJoinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBorderSetting(studentJoinButton, #colorLiteral(red: 1, green: 0.6156862745, blue: 0, alpha: 1))
        studentJoinButton.addTarget(self, action: #selector(studentJoinButtonAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "회원가입"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.title = " "
    }
}

extension SignUpVC {
    
    @objc func studentJoinButtonAction() {
        guard let studentVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentVC") else {return}
        self.navigationController?.pushViewController(studentVC, animated: true)
    }
    
    fileprivate func buttonBorderSetting(_ sender: UIButton, _ color: CGColor) {
        sender.layer.borderWidth = 1.0
        sender.layer.borderColor = color
        sender.layer.masksToBounds = false
        sender.layer.cornerRadius = 6
    }
}
