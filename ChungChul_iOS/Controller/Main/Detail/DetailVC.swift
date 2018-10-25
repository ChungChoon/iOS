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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "테스트"
        
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 274 - (scrollView.contentOffset.y + 274)
        let height = min(max(y, 60), 400)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
    }
    
}
