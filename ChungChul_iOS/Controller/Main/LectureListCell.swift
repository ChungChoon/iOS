//
//  LectureListCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class LectureListCell: UITableViewCell {

    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var lectureListCollectionView: UICollectionView!
    
    var offlineData: [OfflineDataVO]?
    var onlineData: [OnlineDataVO]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nibLectureList = UINib(nibName: "LectureListCVCell", bundle: nil)
        lectureListCollectionView.register(nibLectureList, forCellWithReuseIdentifier: "LectureListCVCell")
        separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegate & UICollectionViewDataSource> (dataSourceDelegate: D, forRow row: Int) {
        lectureListCollectionView.delegate = dataSourceDelegate
        lectureListCollectionView.dataSource = dataSourceDelegate
        lectureListCollectionView.tag = row
        
        lectureListCollectionView.reloadData()
    }
    
}

extension LectureListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if offlineData != nil{
            return (offlineData?.count)!
        } else {
            return (onlineData?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LectureListCVCell", for: indexPath) as! LectureListCVCell
        cell.layer.cornerRadius = 6
        if offlineData != nil{
            let index = offlineData![indexPath.row]
            cell.lectureTitleLabel.text = index.title!
            cell.lectureTermLabel.text = index.startDate! + " ~ " + index.endDate!
            cell.lectureCostLabel.text = "\(index.price!) KLAY"
            cell.lectureAddressLabel.text = index.place!
        } else {
            let index = onlineData![indexPath.row]
            cell.lectureTitleLabel.text = index.title!
            cell.lectureTermLabel.text = index.startDate! + " ~ " + index.endDate!
            cell.lectureCostLabel.text = "\(index.price!) KLAY"
            cell.lectureAddressLabel.text = index.place!
        }
        return cell
    }
    
    
}
