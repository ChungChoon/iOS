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
        borderButton()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    

}

extension SignUpVC {
    
    func borderButton(){
        studentJoinButton.layer.borderWidth = 1.0
        studentJoinButton.layer.borderColor = #colorLiteral(red: 1, green: 0.6156862745, blue: 0, alpha: 1)
        studentJoinButton.layer.masksToBounds = false
        studentJoinButton.layer.cornerRadius = 6
        teacherJoinButton.layer.borderWidth = 1.0
        teacherJoinButton.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
        teacherJoinButton.layer.masksToBounds = false
        teacherJoinButton.layer.cornerRadius = 6
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
