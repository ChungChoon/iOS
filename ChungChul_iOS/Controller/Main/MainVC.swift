//
//  MainVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 16/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet var lectureTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lectureTableView.delegate = self
        lectureTableView.dataSource = self
        lectureTableView.allowsSelection = false
    }


}

extension MainVC {
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = lectureTableView.dequeueReusableCell(withIdentifier: "PopularLectureTVCell", for: indexPath)
        cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
