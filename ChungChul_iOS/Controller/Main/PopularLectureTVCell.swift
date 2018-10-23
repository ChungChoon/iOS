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

}

extension PopularLectureTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = 10
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularLectureCVCell", for: indexPath) as! PopularLectureCVCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 6
        
        return cell
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
