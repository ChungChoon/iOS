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
        blurEffectView(view)
        acceptButton.addTarget(self, action: #selector(acceptButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    fileprivate func blurEffectView(_ view: UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        self.addSubview(view)
    }
    
    @objc func acceptButtonAction(){
        let login = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = login.instantiateViewController(withIdentifier: "InitialNC") as! InitialNC
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
    
    @objc func cancelButtonAction(){
        let main = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = main.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
    }
}
