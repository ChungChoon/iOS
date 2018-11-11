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

class PopularLectureTVCell: UITableViewCell {

    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var popularLectureCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    let collectionMargin = CGFloat(16)
    let itemSpacing = CGFloat(10)
    let itemHeight = CGFloat(290)
    var itemWidth = CGFloat(0)
    
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    
    var popularData : [PopularDataVO]? = nil{
        didSet{
            popularLectureCollectionView.reloadData()
        }
    }
    
    var dateForm = DateFormatter()
    
    var dateFormatter: DateFormatter {
        get {
            let f = DateFormatter()
            f.dateFormat = "yyyy.MM.dd"
            return f
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegate & UICollectionViewDataSource> (dataSourceDelegate: D, forRow row: Int) {
        popularLectureCollectionView.delegate = dataSourceDelegate
        popularLectureCollectionView.dataSource = dataSourceDelegate
        popularLectureCollectionView.tag = row
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        itemWidth = self.contentView.bounds.width - collectionMargin * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        popularLectureCollectionView.collectionViewLayout = layout
        popularLectureCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        popularLectureCollectionView.reloadData()
    }
    
    
    func typeTextButtonSetting(_ sender: UIButton, _ type: Int) {
        switch type {
        case 3:
            sender.setTitle("금융", for: .normal)
        case 4:
            sender.setTitle("법", for: .normal)
        case 5:
            sender.setTitle("농지", for: .normal)
        case 6:
            sender.setTitle("유통", for: .normal)
        case 7:
            sender.setTitle("마케팅", for: .normal)
        case 8:
            sender.setTitle("화훼", for: .normal)
        case 9:
            sender.setTitle("채소", for: .normal)
        case 10:
            sender.setTitle("과일", for: .normal)
        case 11:
            sender.setTitle("농기구", for: .normal)
        default:
            sender.setTitle("타입", for: .normal)
        }
    }
    
    func getEvaluationAveragePoint(_ lectureNumber: Int?) -> Int?{
        var value: Int?
        do {
            let contractAddress = instance.contractAddress
            value = try contractAddress.call("calculateEvaluationAveragePoint(uint256)", lectureNumber!).wait().intCount()
        } catch{
            print("Get Function Result Fail!")
            print(error.localizedDescription)
        }
        return value
    }

}

extension PopularLectureTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
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

        cell.lecturePercentLabel.text = "\(getEvaluationAveragePoint(index.lecturePk!) ?? -10)%"
        cell.lectureTitleLabel.text = index.title
        cell.lectureAddressLabel.text = index.place
        cell.purchaseButton.setTitle("\(index.price!) KLAY", for: .normal)

        cell.farmNameLabel.text = index.farmName
        cell.teacherNameLabel.text = index.name

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = popularData![indexPath.row]

        NotificationCenter.default.post(name: .gotoDetail, object: nil, userInfo: ["lecturePk" : index.lecturePk!])
    }

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
