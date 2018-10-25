//
//  OnOffLineTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 24/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class OnOffLineTVCell: UITableViewCell {

    @IBOutlet var onLineButton: UIButton!
    @IBOutlet var offLineButton: UIButton!
    var flag: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onLineButton.addTarget(self, action: #selector(toggleButtonAction(_:)), for: .touchUpInside)
        offLineButton.addTarget(self, action: #selector(toggleButtonAction(_:)), for: .touchUpInside)
        flagChanging()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension OnOffLineTVCell {
    
    @objc func toggleButtonAction(_ sender: UIButton) {
        if sender.titleLabel?.text == "온라인" {
            flag = 0
            flagChanging()
        } else {
            flag = 1
            flagChanging()
        }
        
    }
    
    func flagChanging(){
        if flag == 0{
            onLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.89), for: .normal)
            offLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38), for: .normal)
        } else {
            offLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.89), for: .normal)
            onLineButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38), for: .normal)
        }
    }
}
