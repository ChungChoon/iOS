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
    @IBOutlet var typeButton: UIButton!
    @IBOutlet var lectureTitleLabel: UILabel!
    @IBOutlet var farmAddressLabel: UILabel!
    @IBOutlet var lectureCountLabel: UILabel!
    @IBOutlet var countRateLabel: UILabel!
    @IBOutlet var lectureProgressBar: UIProgressView!
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var evaluateButton: UIButton!
    @IBOutlet var teacherProfileImageView: UIImageView!
    @IBOutlet var farmNameLabel: UILabel!
    @IBOutlet var teacherNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        evaluateButton.layer.masksToBounds = true
        evaluateButton.layer.cornerRadius = 15
        evaluateButton.layer.borderColor = #colorLiteral(red: 0.388343066, green: 0.5422144532, blue: 0.9160783887, alpha: 1)
        evaluateButton.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
