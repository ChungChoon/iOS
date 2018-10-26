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
    
    var titleTapGestureRecognizer: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lectureTableView.delegate = self
        lectureTableView.dataSource = self
        lectureTableView.allowsSelection = false
        let nibLectureList = UINib(nibName: "LectureListCell", bundle: nil)
        lectureTableView.register(nibLectureList, forCellReuseIdentifier: "LectureListCell")
        navigationBarSetting()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(titleTapAction(_:)))
        self.navigationController?.navigationBar.addGestureRecognizer(titleTapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationBarSetting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.removeGestureRecognizer(titleTapGestureRecognizer)
    }

}

extension MainVC {
    @objc func titleTapAction(_ theObject: AnyObject) {
        guard let typeListVC = self.storyboard?.instantiateViewController(withIdentifier: "TypeListVC") else {return}
        self.present(typeListVC, animated: true, completion: nil)
    }
    
    func navigationBarSetting(){
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Bold", size: 24)!]
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = lectureTableView.dequeueReusableCell(withIdentifier: "PopularLectureTVCell", for: indexPath)
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            
            return cell
        } else {
            let cell = lectureTableView.dequeueReusableCell(withIdentifier: "LectureListCell", for: indexPath)
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
