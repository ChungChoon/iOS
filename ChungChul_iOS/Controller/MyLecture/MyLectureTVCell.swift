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
    @IBOutlet var includeView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
    }
    
    override func layoutSubviews() {
        evaluateButton.layer.masksToBounds = true
        evaluateButton.layer.borderWidth = 1.0
        evaluateButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5920490623, blue: 0, alpha: 1)
        evaluateButton.layer.cornerRadius = 15
        
        includeView.layer.masksToBounds = true
        
        lectureProgressBar.layer.cornerRadius = 6
        lectureProgressBar.clipsToBounds = true
        lectureProgressBar.layer.sublayers![1].cornerRadius = 6
        lectureProgressBar.subviews[1].clipsToBounds = true
        
    }
}
