//
//  PopularLectureTVCell.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 23/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class PopularLectureTVCell: UITableViewCell {

    @IBOutlet var sectionLabel: UILabel!
    @IBOutlet var popularLectureCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    let collectionMargin = CGFloat(16)
    let itemSpacing = CGFloat(10)
    let itemHeight = CGFloat(290)
    var itemWidth = CGFloat(0)
    
    var imgArray: [String] = ["img_popular1","img_popular2","img_popular3","img_popular4","img_popular2"]
    
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
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    func shadowRadiusView(_ shadowView: UIView){
        if shadowLayer == nil {
            print("2")
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3
            
            shadowView.layer.insertSublayer(shadowLayer, at: 0)
        }
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
        let index = popularData![indexPath.row]
        let startDate = index.start_date!
        let endDate = index.end_date!
        cell.lectureImageView.image = UIImage(named: imgArray[indexPath.row])
//        cell.lectureTermLabel.text = dateFormatter.string(from: dateForm.date(from: index.start_date)!) + " ~ " + dateFormatter.string(from: dateForm.date(from: index.end_date)!)
        print(dateForm.date(from: startDate))
        cell.lectureTitleLabel.text = index.title
        cell.lectureAddressLabel.text = index.place
        cell.purchaseButton.setTitle("\(index.price!) KLAY", for: .normal)
        //typeImageViewSetting(cell.typeImageButton)
        cell.farmNameLabel.text = index.farm_name
        cell.teacherNameLabel.text = index.name
       shadowRadiusView(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: .gotoDetail, object: nil, userInfo: ["row" : indexPath.row])
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
