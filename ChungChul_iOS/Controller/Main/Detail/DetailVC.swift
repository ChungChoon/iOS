//
//  DetailVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var applyButton: UIButton!
    
    var aaa = ["123", "2323" , "32323", "1111"]
    
    let headerView: HeaderView = {
        let v = HeaderView()
        v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 274)
        v.backImageView.image = #imageLiteral(resourceName: "1")
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.contentInset = UIEdgeInsets(top: 274, left: 0, bottom: 0, right: 0)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        headerViewSetting()
    }

}

extension DetailVC {
    
    func headerViewSetting(){
        view.addSubview(headerView)

    }
    
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "InformationTVCell") as! InformationTVCell
            return cell
        case 1:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "IntroduceTVCell") as! IntroduceTVCell
            return cell
        case 2:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "PlanTVCell") as! PlanTVCell
            
            
            
            return cell
        case 3:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "TeacherTVCell") as! TeacherTVCell
            return cell
        case 4:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "CommentTVCell") as! CommentTVCell
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 274 - (scrollView.contentOffset.y + 274)
        let height = min(max(y, 64), 600)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
    }
    
}
