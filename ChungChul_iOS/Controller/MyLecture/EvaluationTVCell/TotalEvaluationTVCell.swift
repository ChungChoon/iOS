//
//  TotalEvaluatuonTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 01/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class TotalEvaluationTVCell: UITableViewCell {

    // UI IBOutlet Variable
    @IBOutlet var ratingView: RatingView!
    @IBOutlet var percentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetting()
        rateViewUISetting()
    }
    
    fileprivate func cellSetting() {
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    fileprivate func rateViewUISetting() {
        for index in 0..<5 {
            ratingView.ratingViewArray[index].layer.masksToBounds = true
            ratingView.ratingViewArray[index].layer.cornerRadius = ratingView.frame.height / 2
            ratingView.ratingViewArray[index].backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        }
    }
}
