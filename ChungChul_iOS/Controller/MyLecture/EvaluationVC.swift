//
//  EvaluationVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 01/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class EvaluationVC: UIViewController {
    
    @IBOutlet var evaluationTableView: UITableView!
    @IBOutlet var doneButton: UIButton!
    
    var colorArray: [UIColor] = [#colorLiteral(red: 0.3176470588, green: 0.8941176471, blue: 0.6705882353, alpha: 1),#colorLiteral(red: 0.1764705882, green: 0.8666666667, blue: 0.7607843137, alpha: 1),#colorLiteral(red: 0.2862745098, green: 0.8431372549, blue: 0.9176470588, alpha: 1),#colorLiteral(red: 0.2392156863, green: 0.7411764706, blue: 0.8901960784, alpha: 1),#colorLiteral(red: 0.3725490196, green: 0.6078431373, blue: 0.8941176471, alpha: 1)]
    
    let evaluationTitleArray: [String] = [
        "수업준비",
        "수업내용",
        "진행방식",
        "커뮤니케이션",
        "전체적인 만족도"
        ]
    let evaluationSubjectArray: [String] = [
    "강사가 수업준비에 성실하였나요?",
    "수업 내용에 대해 만족하셨나요?",
    "강사의 강의 진행방식에 대해 만족하셨나요?",
    "강사와 커뮤니케이션이 잘 되었나요?",
    "전체적인 만족도에 대해 입력 해주세요"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        evaluationTableView.delegate = self
        evaluationTableView.dataSource = self
    }
}

extension EvaluationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else if section == 1{
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = evaluationTableView.dequeueReusableCell(withIdentifier: "TotalEvaluationTVCell") as! TotalEvaluationTVCell
            
            //TODO: Get Evaluation Data from Sever
            
            return cell
        case 1:
            let cell = evaluationTableView.dequeueReusableCell(withIdentifier: "EvaluationListTVCell") as! EvaluationListTVCell
            let index = indexPath.row
            cell.titleLabel.text = evaluationTitleArray[index]
            cell.subjectLabel.text = evaluationSubjectArray[index]
            cell.colorFromVC = colorArray[index]
            return cell
        case 2:
            let cell = evaluationTableView.dequeueReusableCell(withIdentifier: "DescriptionTVCell") as! DescriptionTVCell
            cell.delegate = self as ExpandingCellDelegate
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension EvaluationVC: ExpandingCellDelegate {
    
    func updated(height: CGFloat) {
        
        // Disabling animations gives us our desired behaviour
        UIView.setAnimationsEnabled(false)
        /* These will causes table cell heights to be recaluclated,
         without reloading the entire cell */
        evaluationTableView.beginUpdates()
        evaluationTableView.endUpdates()
        // Re-enable animations
        UIView.setAnimationsEnabled(true)
        
        let indexPath = IndexPath(row: 0, section: 2)
        
        evaluationTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
}
