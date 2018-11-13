//
//  UIViewControllerExtension.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 13/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import Lottie

extension UIViewController {
    
    func navigationBarSetting(title: String, isTranslucent: Bool){
        self.title = title
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Bold", size: 24)!]
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // Indicator View Setting Because of Downloading Klaytn Data
    func indicatorViewSetting(_ indicatorView: UIView, _ animationView: LOTAnimationView) {
        UIApplication.shared.keyWindow!.addSubview(indicatorView)
        indicatorView.contentMode = .scaleAspectFill
        indicatorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = indicatorView.center
        animationView.loopAnimation = true
        indicatorView.addSubview(animationView)
        animationView.play()
    }
}

extension UIViewController : UITextFieldDelegate, UIScrollViewDelegate{
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    func gsno(_ data: String?) -> String {
        guard let str = data else {
            return ""
        }
        return str
    }
    
    func gino(_ data: Int?) -> Int {
        guard let num = data else {
            return 0
        }
        return num
    }
    
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

