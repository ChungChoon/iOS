//
//  LectureListCVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class LectureListCVCell: UICollectionViewCell {

    // UI IBOutlet Variable
    @IBOutlet var lectureImageView: UIImageView!
    @IBOutlet var typeButton: UIButton!
    @IBOutlet var lectureCountLabel: UILabel!
    @IBOutlet var lectureCostLabel: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var lectureTitleLabel: UILabel!
    @IBOutlet var lectureAddressLabel: UILabel!
    @IBOutlet var lectureTermLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
