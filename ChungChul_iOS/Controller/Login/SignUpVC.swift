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

        studentJoinButton.addTarget(self, action: #selector(studentJoinButtonAction), for: .touchUpInside)
        teacherJoinButton.addTarget(self, action: #selector(teacherJoinButtonAction), for: .touchUpInside)
    }

}

extension SignUpVC {
    
    @objc func studentJoinButtonAction() {
        
    }
    
    @objc func teacherJoinButtonAction() {
        
    }
}
