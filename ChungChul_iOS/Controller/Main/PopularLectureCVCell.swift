//
//  PopularLectureCVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class PopularLectureCVCell: UICollectionViewCell {
    
    // UI IBOutlet Variable
    @IBOutlet var typeImageButton: UIButton!
    @IBOutlet var lectureTitleLabel: UILabel!
    @IBOutlet var lectureAddressLabel: UILabel!
    @IBOutlet var lectureNumberOfTimeLabel: UILabel!
    @IBOutlet var lectureImageView: UIImageView!
    @IBOutlet var lecturePercentLabel: UILabel!
    @IBOutlet var lectureTermLabel: UILabel!
    
    @IBOutlet var teacherImageView: UIImageView!
    @IBOutlet var farmNameLabel: UILabel!
    @IBOutlet var teacherNameLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

