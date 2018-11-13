//
//  MyLectureTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 24/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class MyLectureTVCell: UITableViewCell {
    
    // UI IBOutlet Variable
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
    
    // Variable
    let screenFrameSize = UIScreen.main.bounds
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetting()
    }
    
    override func layoutSubviews() {
        evaluateButtonUISetting()
        includeViewUISetting()
        progressBarUISetting()
    }
    
    fileprivate func cellSetting() {
        self.separatorInset = UIEdgeInsets(top: 0, left: screenFrameSize.width, bottom: 0, right: 0)
    }
    
    fileprivate func evaluateButtonUISetting() {
        evaluateButton.layer.masksToBounds = true
        evaluateButton.layer.borderWidth = 1.0
        evaluateButton.layer.borderColor = #colorLiteral(red: 1, green: 0.5920490623, blue: 0, alpha: 1)
        evaluateButton.layer.cornerRadius = 15
    }
    
    fileprivate func includeViewUISetting() {
        includeView.layer.masksToBounds = true
    }
    
    fileprivate func progressBarUISetting() {
        lectureProgressBar.layer.cornerRadius = 6
        lectureProgressBar.clipsToBounds = true
        lectureProgressBar.layer.sublayers![1].cornerRadius = 6
        lectureProgressBar.subviews[1].clipsToBounds = true
    }
}
