//
//  EvaluationListTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 02/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class EvaluationListTVCell: UITableViewCell {

    // UI IBOutlet Variable
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var rateView: RatingView!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var plusButton: UIButton!
    
    // Variable
    var value: Int = 0
    var count: Int = 0
    var colorFromVC: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetting()
        buttonUISetting(minusButton)
        buttonUISetting(plusButton)
        addTargetButton()
        rateViewSetting()
        invalidateIntrinsicContentSize()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectedCellSetting(#colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1), #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1))
        } else {
            selectedCellSetting(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))
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
    
    fileprivate func rateViewSetting() {
        for index in 0..<5 {
            rateView.ratingViewArray[index].layer.masksToBounds = true
            rateView.ratingViewArray[index].layer.cornerRadius = 10
        }
    }
    
    fileprivate func cellSetting() {
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    fileprivate func buttonUISetting(_ button: UIButton) {
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.borderWidth = 1.0
        button.layer.borderColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
    }
    
    fileprivate func addTargetButton() {
        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
    }
    
    fileprivate func selectedCellSetting(_ color: UIColor, _ cgColor: CGColor) {
        titleLabel.textColor = color
        minusButton.titleLabel?.textColor = color
        minusButton.layer.borderColor = cgColor
        plusButton.titleLabel?.textColor = color
        plusButton.layer.borderColor = cgColor
    }
}
