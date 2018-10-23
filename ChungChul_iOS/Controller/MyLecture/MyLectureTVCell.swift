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
    @IBOutlet var teacherImageView: UIImageView!
    @IBOutlet var farmNameLabel: UILabel!
    @IBOutlet var teacherNameLabel: UILabel!
    @IBOutlet var lectureCountLabel: UILabel!
    @IBOutlet var countRateLabel: UILabel!
    @IBOutlet var lectureProgressBar: UIProgressView!
    @IBOutlet var farmAddressLabel: UILabel!
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var voteButton: UIButton!
    @IBOutlet var bottmView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
