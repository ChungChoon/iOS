//
//  Extension.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    //MARK: TextField UnderLine Make
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height-height+5, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

extension UIViewController : UITextFieldDelegate, UIScrollViewDelegate{
    
    func typeTextButtonSetting(_ sender: UIButton, _ type: Int) {
        switch type {
        case 3:
            sender.setTitle("금융", for: .normal)
        case 4:
            sender.setTitle("법", for: .normal)
        case 5:
            sender.setTitle("농지", for: .normal)
        case 6:
            sender.setTitle("유통", for: .normal)
        case 7:
            sender.setTitle("마케팅", for: .normal)
        case 8:
            sender.setTitle("화훼", for: .normal)
        case 9:
            sender.setTitle("채소", for: .normal)
        case 10:
            sender.setTitle("과일", for: .normal)
        case 11:
            sender.setTitle("농기구", for: .normal)
        default:
            sender.setTitle("타입", for: .normal)
        }
    }
    
    func typeImageViewSetting(_ button: UIButton){
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1), for: .normal)
    }
    
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
    
    func getCurrentMillis()->Int64 {
        return Int64(Int64(Date().timeIntervalSince1970 * 1000))
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}

extension UIView {
    
    
    // OUTPUT 1
    func dropShadow() {
        // set the corner radius
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
        // set the shadow properties
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 6.0
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.cornerRadius = 6
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

