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
        if offlineData != nil {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = lectureListCollectionView.cellForItem(at: indexPath) as! LectureListCVCell
        
        if offlineData != nil {
            let index = offlineData![indexPath.row]
            let evaluationPointIndex = cell.getEvaluationAveragePoint(index.lecturePk!)
            let evaluationPointText = cell.getEvaluationAveragePointText(index.lecturePk!)
            NotificationCenter.default.post(name: .gotoDetail, object: nil, userInfo: [
                "lecturePk" : index.lecturePk!,
                "evaluationPointText" : evaluationPointText,
                "evaluationPointIndex": evaluationPointIndex
                ])
        } else {
            let index = onlineData![indexPath.row]
            let evaluationPointIndex = cell.getEvaluationAveragePoint(index.lecturePk!)
            let evaluationPointText = cell.getEvaluationAveragePointText(index.lecturePk!)
            NotificationCenter.default.post(name: .gotoDetail, object: nil, userInfo: [
                "lecturePk" : index.lecturePk!,
                "evaluationPointText" : evaluationPointText,
                "evaluationPointIndex": evaluationPointIndex
                ])
        }
    }

    
}
