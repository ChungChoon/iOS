//
//  DescriptionTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 02/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

// Expand Description TextView Cell Protocol
protocol ExpandingCellDelegate {
    func updated(height: CGFloat)
}

class DescriptionTVCell: UITableViewCell {

    // UI IBOutlet Variable
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var delegate: ExpandingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            titleLabel.textColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
        } else {
            titleLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        }
    }
}

extension DescriptionTVCell {
    
    fileprivate func cellSetting() {
        descriptionTextView.delegate = self
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension DescriptionTVCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let height = textView.newHeight(withBaseHeight: 200)
        delegate?.updated(height: height)
    }
}
