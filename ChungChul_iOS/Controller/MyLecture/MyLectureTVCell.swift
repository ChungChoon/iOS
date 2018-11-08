//
//  MyLectureTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 24/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class MyLectureTVCell: UITableViewCell {
    
    @IBOutlet var lectureImageView: UIImageView!
    @IBOutlet var typeImageView: UIImageView!
    @IBOutlet var lectureTitleLabel: UILabel!
    @IBOutlet var farmNameLabel: UILabel!
    @IBOutlet var lectureCountLabel: UILabel!
    @IBOutlet var countRateLabel: UILabel!
    @IBOutlet var lectureProgressBar: UIProgressView!
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var voteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        voteButton.layer.masksToBounds = true
        voteButton.layer.cornerRadius = 15
        voteButton.layer.borderColor = #colorLiteral(red: 0.388343066, green: 0.5422144532, blue: 0.9160783887, alpha: 1)
        voteButton.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
