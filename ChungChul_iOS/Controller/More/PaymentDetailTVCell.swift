//
//  PaymentDetailTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 15/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class PaymentDetailTVCell: UITableViewCell {

    @IBOutlet var lectureNumberButton: UIButton!
    @IBOutlet var lectureTitleLabel: UILabel!
    @IBOutlet var lecturePaymentDateLabel: UILabel!
    @IBOutlet var paidKlayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lectureNumberButton.layer.cornerRadius = lectureNumberButton.frame.size.width / 2
    }
}
