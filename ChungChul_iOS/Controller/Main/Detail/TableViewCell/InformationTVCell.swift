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
    @IBOutlet var rateImageView: UIImageView!
    @IBOutlet var voteCountLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
