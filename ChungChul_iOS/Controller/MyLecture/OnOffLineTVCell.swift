//
//  OnOffLineTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 24/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class OnOffLineTVCell: UITableViewCell {

    // UI IBOutlet Variable
    @IBOutlet var onLineButton: UIButton!
    @IBOutlet var offLineButton: UIButton!
    
    // Variable
    var flag: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTargetButton()
        flagChanging()
        cellSetting()
    }
    
}

extension OnOffLineTVCell {
    
    // Toggle Button Action Selector
    @objc func toggleButtonAction(_ sender: UIButton) {
        if sender.titleLabel?.text == "온라인" {
            flag = 0
            flagChanging()
        } else {
            flag = 1
            flagChanging()
        }
    }
    
    fileprivate func cellSetting() {
        self.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
    }
    
    fileprivate func addTargetButton() {
        onLineButton.addTarget(self, action: #selector(toggleButtonAction(_:)), for: .touchUpInside)
        offLineButton.addTarget(self, action: #selector(toggleButtonAction(_:)), for: .touchUpInside)
    }
    
    fileprivate func flagChanging(){
        if flag == 0{
            onLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.89), for: .normal)
            offLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38), for: .normal)
        } else {
            offLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.89), for: .normal)
            onLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38), for: .normal)
        }
    }
}
