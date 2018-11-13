//
//  CommentTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import SDWebImage

class CommentTVCell: UITableViewCell {

    // UI IBOutlet Variable
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var rateView: RatingView!
    @IBOutlet var commentCountLabel: UILabel!
    @IBOutlet var commentTableView: UITableView!
    
    // Variable
    var tableViewHeight: Int = 0
    
    // Data Variable
    var reviewDataFromServer: [LectureReviewDataVO]?  = nil{
        didSet{
            tableViewHeight = (reviewDataFromServer?.count)! * 88
            commentTableView.heightAnchor.constraint(equalToConstant: CGFloat(tableViewHeight)).isActive = true
            commentTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateViewUISetting()
        tableViewSetting()
    }
    
    fileprivate func tableViewSetting() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.tableFooterView = UIView(frame: CGRect.zero)
        commentTableView.tableHeaderView = UIView(frame: CGRect.zero)
        commentTableView.allowsSelection = false
        commentTableView.separatorInset = UIEdgeInsets(top: 0, left: 15.5, bottom: 0, right: 15.5)
    }
    
    fileprivate func rateViewUISetting() {
        for index in 0..<5 {
            rateView.ratingViewArray[index].layer.masksToBounds = true
            rateView.ratingViewArray[index].layer.cornerRadius = rateView.frame.height / 2
            rateView.ratingViewArray[index].backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        }
    }

}

//MARK: TableView Delegate and DataSource
extension CommentTVCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewDataFromServer == nil {
            return 2
        } else {
            return (reviewDataFromServer?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return commentCell(indexPath)
    }
    
    fileprivate func commentCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let index = reviewDataFromServer![indexPath.row]
        cell.userNameLabel.text = index.name!
        cell.commentLabel.text = index.content!
        cell.userImageView.sd_setImage(with: URL(string: index.img!), placeholderImage: UIImage(named: "ic_2people_28"))
        return cell
    }
}

// Review Each Cell
class CommentCell: UITableViewCell {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var writtenTimeLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }
}
