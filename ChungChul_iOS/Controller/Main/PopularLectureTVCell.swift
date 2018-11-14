//
//  PopularLectureTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift
import BigInt
import SDWebImage

class PopularLectureTVCell: UITableViewCell {

    // UI IBOutlet Variable
    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var popularLectureCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    // CollectionView Flow Layout Variable
    let collectionMargin = CGFloat(16)
    let itemSpacing = CGFloat(10)
    let itemHeight = CGFloat(290)
    var itemWidth = CGFloat(0)
    let screenFrameSize = UIScreen.main.bounds
    
    // Caver Singleton Instance Variable
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    
    // Data Variable
    var popularData : [PopularDataVO]?
    var evaluationPointTextArray: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: screenFrameSize.width, bottom: 0, right: 0)
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 0)
    }
    
    // Set ColletionView Delegate and DataSource by Protocol
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegate & UICollectionViewDataSource> (dataSourceDelegate: D, forRow row: Int) {
        popularLectureCollectionView.delegate = dataSourceDelegate
        popularLectureCollectionView.dataSource = dataSourceDelegate
        popularLectureCollectionView.tag = row
        collectionViewFlowLayout()
        popularLectureCollectionView.reloadData()
    }
}

extension PopularLectureTVCell {
    
    // CollectionView Flow Layout Setting
    fileprivate func collectionViewFlowLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        itemWidth = self.contentView.bounds.width - collectionMargin * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: itemWidth, height: self.contentView.bounds.height - 39.5)
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        popularLectureCollectionView.collectionViewLayout = layout
        popularLectureCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    // Get Evaluation Point Data From Klaytn
    public func getEvaluationDataOnKlaytn(){
        DispatchQueue.global().async {
            print("Start Downloading on Klaytn")
            self.evaluationPointTextArray.removeAll()
            if self.popularData != nil{
                for index in self.popularData!{
                    let resultText = self.getEvaluationAveragePointText(index.lecturePk!)
                    self.evaluationPointTextArray.append(resultText)
                }
            }
            DispatchQueue.main.async {
                print("Finish Downloading on Klaytn")
                self.popularLectureCollectionView.reloadData()
                NotificationCenter.default.post(name: .finishDownloadKlaytnData, object: nil)
            }
        }
    }
}

//MARK: CollectionView Delegate and DataSource
extension PopularLectureTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if popularData != nil {
            self.pageControl.numberOfPages = (popularData?.count)!
            return (popularData?.count)!
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularLectureCVCell", for: indexPath) as! PopularLectureCVCell
        cell.backgroundColor = UIColor.yellow
        let index = popularData![indexPath.row]
        
        cell.typeImageButton.typeButtonTextSetting(cell.typeImageButton, index.kind!)
        cell.lectureTitleLabel.text = index.title
        cell.lectureAddressLabel.text = index.place
        cell.purchaseButton.setTitle("\(index.price!) KLAY", for: .normal)
        cell.farmNameLabel.text = index.farmName
        cell.teacherNameLabel.text = index.name
        cell.lectureTermLabel.text = index.startDate! + " ~ " + index.endDate!
        cell.lectureImageView.sd_setImage(with: URL(string: index.img ?? ""), placeholderImage: UIImage(named: "img_popular1"))
        
        if evaluationPointTextArray.count != 0{
            cell.lecturePercentLabel.text = evaluationPointTextArray[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = popularData![indexPath.row]
        let cell = popularLectureCollectionView.cellForItem(at: indexPath) as! PopularLectureCVCell
        let evaluationPointIndex = cell.getEvaluationAveragePoint(index.lecturePk!)
        let evaluationPointText = cell.getEvaluationAveragePointText(index.lecturePk!)
        
        NotificationCenter.default.post(name: .gotoDetail, object: nil, userInfo: [
            "lecturePk" : index.lecturePk!,
            "evaluationPointText" : evaluationPointText,
            "evaluationPointIndex": evaluationPointIndex
        ])
    }
}

//MARK: ScrollView Delegate
extension PopularLectureTVCell: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(popularLectureCollectionView.contentSize.width  )
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}
