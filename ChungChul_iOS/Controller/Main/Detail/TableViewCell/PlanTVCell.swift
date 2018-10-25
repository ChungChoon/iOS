//
//  PlanTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class PlanTVCell: UITableViewCell {
    
    @IBOutlet var planTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        planTableView.delegate = self
        planTableView.dataSource = self
        planTableView.heightAnchor.constraint(equalToConstant: 10*20).isActive = true
        planTableView.allowsSelection = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PlanTVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = planTableView.dequeueReusableCell(withIdentifier: "PlanCell", for: indexPath) as! PlanCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.planLabel.text = "테스트"
        cell.lineImageView.backgroundColor = UIColor.red
        return cell
    }
    
    
}

class PlanCell: UITableViewCell {
    
    @IBOutlet var lineImageView: UIImageView!
    @IBOutlet var planLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
