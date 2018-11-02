//
//  TotalEvaluatuonTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 01/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class TotalEvaluationTVCell: UITableViewCell {

    @IBOutlet var countEvaluationLabel: UILabel!
    @IBOutlet var ratingView: RatingView!
    @IBOutlet var percentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        percentLabel.text = "0"
        
        for index in 0..<5 {
            ratingView.ratingViewArray[index].layer.masksToBounds = true
            ratingView.ratingViewArray[index].layer.cornerRadius = ratingView.ratingViewArray[index].frame.size.width / 2
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}
