//
//  InformationTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class InformationTVCell: UITableViewCell {
    
    @IBOutlet var voteRateLabel: UILabel!
    @IBOutlet var rateView: RatingView!
    @IBOutlet var voteCountLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateViewUISetting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func rateViewUISetting() {
        for index in 0..<5 {
            rateView.ratingViewArray[index].layer.masksToBounds = true
            rateView.ratingViewArray[index].layer.cornerRadius = rateView.frame.height / 2
            rateView.ratingViewArray[index].backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        }
    }
}
