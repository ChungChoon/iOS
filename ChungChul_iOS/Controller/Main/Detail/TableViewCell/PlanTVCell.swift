//
//  PlanTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class PlanTVCell: UITableViewCell {
    
    // UI IBOutlet Variable
    @IBOutlet var planTableView: UITableView!
    
    var curriculumDataFromServer: [LectureCurriculumDataVO]? = nil{
        didSet{
            let tableViewHeight = ((curriculumDataFromServer?.count)! - 1) * 60
            planTableView.heightAnchor.constraint(equalToConstant: CGFloat(tableViewHeight)).isActive = true
            planTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewSetting()
    }

    fileprivate func tableViewSetting() {
        planTableView.delegate = self
        planTableView.dataSource = self
        planTableView.allowsSelection = false
        planTableView.tableFooterView = UIView(frame: CGRect.zero)
        planTableView.tableHeaderView = UIView(frame: CGRect.zero)
        planTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension PlanTVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if curriculumDataFromServer == nil {
            return 1
        } else {
            return (curriculumDataFromServer?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = planTableView.dequeueReusableCell(withIdentifier: "PlanCell", for: indexPath) as! PlanCell
        let index = curriculumDataFromServer![indexPath.row]
        cell.curriculumTitleLabel.text = "\(indexPath.row + 1) 주차" + " - " + index.title!
        cell.curriculumContentLabel.text! = index.content!
        return cell
    }
    
    
}

// Plan Each Cell
class PlanCell: UITableViewCell {
    
    @IBOutlet var curriculumTitleLabel: UILabel!
    @IBOutlet var curriculumContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
