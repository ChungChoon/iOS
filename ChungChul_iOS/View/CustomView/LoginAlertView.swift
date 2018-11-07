//
//  LoginAlertView.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 08/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class LoginAlertView: UIView {
    
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed("LoginAlertView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
    }
}
