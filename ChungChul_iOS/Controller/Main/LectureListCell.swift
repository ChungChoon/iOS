//
//  LectureListCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class LectureListCell: UITableViewCell {

    // UI IBOutlet Variable
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var lectureListCollectionView: UICollectionView!
    
    // Data Variable
    var offlineData: [OfflineDataVO]?
    var onlineData: [OnlineDataVO]?
    
    // Variable
    let screenFrameSize = UIScreen.main.bounds
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSetting()
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 0)
        
    }

    // Set ColletionView Delegate and DataSource by Protocol
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegate & UICollectionViewDataSource> (dataSourceDelegate: D, forRow row: Int) {
        lectureListCollectionView.delegate = dataSourceDelegate
        lectureListCollectionView.dataSource = dataSourceDelegate
        lectureListCollectionView.tag = row
        lectureListCollectionView.reloadData()
    }
}

extension LectureListCell {
    
    // CollectionView Setting and XIB Register
    fileprivate func collectionViewSetting() {
        let nibLectureList = UINib(nibName: "LectureListCVCell", bundle: nil)
        lectureListCollectionView.register(nibLectureList, forCellWithReuseIdentifier: "LectureListCVCell")
        separatorInset = UIEdgeInsets(top: 0, left: screenFrameSize.width, bottom: 0, right: 0)
    }
}

//MARK: CollectionView Delegate and DataSource
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
            cell.lectureCountLabel.text = "총 \(index.curriculumCount!)회"
            cell.typeButton.typeButtonTextSetting(cell.typeButton, index.kind!)
        } else {
            let index = onlineData![indexPath.row]
            cell.lectureTitleLabel.text = index.title!
            cell.lectureTermLabel.text = index.startDate! + " ~ " + index.endDate!
            cell.lectureCostLabel.text = "\(index.price!) KLAY"
            cell.lectureAddressLabel.text = index.place!
            cell.lectureCountLabel.text = "총 \(index.curriculumCount!)회"
            cell.typeButton.typeButtonTextSetting(cell.typeButton, index.kind!)
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
