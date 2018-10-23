//
//  TypeListVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class TypeListVC: UIViewController {
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var uiSettingButton: [UIButton]!
    
    @IBOutlet var totalButton: UIButton!
    @IBOutlet var baseEduTotalButton: UIButton!
    @IBOutlet var exerciseEduTotalButton: UIButton!
    
    @IBOutlet var baseEduButton: [UIButton]!
    @IBOutlet var financeButton: UIButton!
    @IBOutlet var lawButton: UIButton!
    @IBOutlet var farmButton: UIButton!
    @IBOutlet var distributionButton: UIButton!
    @IBOutlet var marketingButton: UIButton!
    
    @IBOutlet var exerciseEduButton: [UIButton]!
    @IBOutlet var flowerButton: UIButton!
    @IBOutlet var vegetableButton: UIButton!
    @IBOutlet var fruitButton: UIButton!
    @IBOutlet var agriculturalButton: UIButton!
    
    @IBOutlet var termEduButton: [UIButton]!
    @IBOutlet var weekendButton: UIButton!
    @IBOutlet var shortTermButton: UIButton!
    @IBOutlet var longTermButton: UIButton!
    
    @IBOutlet var targetEduButton: [UIButton]!
    @IBOutlet var womanButton: UIButton!
    @IBOutlet var youngManButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonUISetting()
    }
    
}

extension TypeListVC {
    
    func buttonUISetting(){
        var index: Int = 0
        for button in uiSettingButton {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 6
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.tag = index
            index += 1
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 9, bottom: 5, right: 9)
            button.addTarget(self, action: #selector(buttonClickAction(_:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonClickAction(_ sender: UIButton) {
        
        if sender.tag == 0 && sender.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
            for button in uiSettingButton {
                button.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            }
        } else if sender.tag == 0 && sender.backgroundColor == #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1) {
            for button in uiSettingButton {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1), for: .normal)
            }
        } else if sender.tag == 1 && sender.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
            for button in baseEduButton {
                button.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            }
        } else if sender.tag == 1 && sender.backgroundColor == #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1) {
            for button in baseEduButton {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1), for: .normal)
            }
        } else if sender.tag == 2 && sender.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
            for button in exerciseEduButton {
                button.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            }
        } else if sender.tag == 2 && sender.backgroundColor == #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1) {
            for button in exerciseEduButton {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1), for: .normal)
            }
        } else {
            if sender.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
                sender.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            } else {
                sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                sender.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1), for: .normal)
            }
        }
        
    }
}
