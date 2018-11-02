//
//  EvaluationListTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 02/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class EvaluationListTVCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var rateView: RatingView!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var plusButton: UIButton!
    
    var value: Int = 0
    var count: Int = 0
    var colorFromVC: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        percentLabel.text = "0%"
        
        minusButton.layer.masksToBounds = true
        minusButton.layer.cornerRadius = minusButton.frame.width / 2
        minusButton.layer.borderWidth = 1.0
        minusButton.layer.borderColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
        
        plusButton.layer.masksToBounds = true
        plusButton.layer.cornerRadius = plusButton.frame.width / 2
        plusButton.layer.borderWidth = 1.0
        plusButton.layer.borderColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        
        for index in 0..<5 {
            rateView.ratingViewArray[index].layer.masksToBounds = true
            rateView.ratingViewArray[index].layer.cornerRadius = 10
        }

        invalidateIntrinsicContentSize()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            titleLabel.textColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            minusButton.titleLabel?.textColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            minusButton.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            plusButton.titleLabel?.textColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            plusButton.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            var bottomBorder = CALayer()
            bottomBorder.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            bottomBorder.frame = CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)
            cell.layer.addSublayer(bottomBorder)
            
        } else {
            titleLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            minusButton.titleLabel?.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            minusButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            plusButton.titleLabel?.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            plusButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            var bottomBorder = CALayer()
            bottomBorder.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            bottomBorder.frame = CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)
            cell.layer.addSublayer(bottomBorder)
        }
    }

}

extension EvaluationListTVCell {
    
    @objc func plusButtonAction(){
        if value < 100{
            value += 20
            count += 1
            percentLabel.text = "\(value)%"
            for i in 0..<count{
                rateView.ratingViewArray[i].backgroundColor = colorFromVC
            }
        }
    }
    
    @objc func minusButtonAction(){
        if value > 0 {
            value -= 20
            count -= 1
            percentLabel.text = "\(value)%"
            for i in (count..<5).reversed(){
                rateView.ratingViewArray[i].backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            }
        }
    }
}
