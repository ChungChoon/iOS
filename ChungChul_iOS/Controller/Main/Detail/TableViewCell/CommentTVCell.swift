//
//  CommentTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class CommentTVCell: UITableViewCell {

    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var rateImageView: UIImageView!
    @IBOutlet var commentCountLabel: UILabel!
    @IBOutlet var commentTableView: UITableView!
    
    var tableViewHeight: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.tableFooterView = UIView(frame: CGRect.zero)
        commentTableView.tableHeaderView = UIView(frame: CGRect.zero)
        commentTableView.allowsSelection = false
        commentTableView.heightAnchor.constraint(equalToConstant: 10*88).isActive = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CommentTVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.userImageView.backgroundColor = UIColor.red
        tableViewHeight += cell.frame.size.height
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15.5, bottom: 0, right: 15.5)
        print(tableViewHeight)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
    
}

class CommentCell: UITableViewCell {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var writtenTimeLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
