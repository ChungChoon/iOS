//
//  SignUpVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 17/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet var studentJoinButton: UIButton!
    @IBOutlet var teacherJoinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBorderSetting(studentJoinButton, #colorLiteral(red: 1, green: 0.6156862745, blue: 0, alpha: 1))
        buttonBorderSetting(teacherJoinButton, #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1))
        studentJoinButton.addTarget(self, action: #selector(studentJoinButtonAction), for: .touchUpInside)
        teacherJoinButton.addTarget(self, action: #selector(teacherJoinButtonAction), for: .touchUpInside)
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
    
    fileprivate func buttonBorderSetting(_ sender: UIButton, _ color: CGColor) {
        sender.layer.borderWidth = 1.0
        sender.layer.borderColor = color
        sender.layer.masksToBounds = false
        sender.layer.cornerRadius = 6
    }
    
    @objc func studentJoinButtonAction() {
        guard let studentVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentVC") else {return}
        self.navigationController?.pushViewController(studentVC, animated: true)
    }
    
    @objc func teacherJoinButtonAction() {
        guard let teacherVC = self.storyboard?.instantiateViewController(withIdentifier: "TeacherVC") else {return}
        self.navigationController?.pushViewController(teacherVC, animated: true)
    }
}
