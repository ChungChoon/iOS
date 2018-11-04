//
//  TypeListVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

protocol TypeSaveDelegate {
    func updateType(_ typeList: [String])
}

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
    
    var delegate: TypeSaveDelegate?
    var typeList: [String] = []
    var typeMappingDictionary: [Int: String] = [
        0:"전체",
        1:"기초 교육 전체",
        2:"실습 교육 전체",
        3:"금융",
        4:"법",
        5:"농지",
        6:"유통",
        7:"마케팅",
        8:"화훼",
        9:"채소",
        10:"과일",
        11:"농기구",
        12:"주말",
        13:"단기",
        14:"장기",
        15:"여성",
        16:"청년"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonUISetting()
    }
    
}

extension TypeListVC {
    
    @objc func saveButtonAction(){
        if typeList.isEmpty {
            typeList.append("전체")
        }
        self.delegate?.updateType(typeList)
        self.dismiss(animated: true, completion: nil)
    }
    
    func buttonUISetting(){
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
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
    
    func buttonTagSetting(){
        
    }
    
    fileprivate func totalButtonSettingOnClick(_ buttonArray: [UIButton], _ buttonTag: Int) {
        for button in buttonArray {
            button.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
            button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        }
        typeList.append(typeMappingDictionary[buttonTag]!)
    }
    
    fileprivate func totalButtonSettingUnClick(_ buttonArray: [UIButton], _ buttonTag: Int) {
        for button in buttonArray {
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1), for: .normal)
        }
        if let index = typeList.index(of: typeMappingDictionary[buttonTag]!){
            typeList.remove(at: index)
        }
    }
    
    fileprivate func buttonSettingOnClick(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1)
        sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        typeList.append(typeMappingDictionary[sender.tag]!)
    }
    
    fileprivate func buttonSettingUnClick(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        sender.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4509803922, blue: 0.8941176471, alpha: 1), for: .normal)
        if let index = typeList.index(of: typeMappingDictionary[sender.tag]!){
            typeList.remove(at: index)
        }
    }
    
    fileprivate func totalButtonStatus(_ sender: UIButton, _ buttonArray: [UIButton]) {
        if sender.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1){
            totalButtonSettingOnClick(buttonArray, sender.tag)
        } else{
            totalButtonSettingUnClick(buttonArray, sender.tag)
        }
    }
    
    fileprivate func defaultButtonStatus(_ sender: UIButton) {
        if sender.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1){
            buttonSettingOnClick(sender)
        } else{
            buttonSettingUnClick(sender)
        }
    }
    
    @objc func buttonClickAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            totalButtonStatus(sender,uiSettingButton)
        case 1:
            totalButtonStatus(sender,baseEduButton)
        case 2:
            totalButtonStatus(sender,exerciseEduButton)
        default:
            defaultButtonStatus(sender)
        }
    }
}
