//
//  MyLectureVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 24/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class MyLectureVC: UIViewController {

    @IBOutlet var myLectureTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibMyLecture = UINib(nibName: "MyLectureTVCell", bundle: nil)
        myLectureTableView.delegate = self
        myLectureTableView.dataSource = self
        myLectureTableView.register(nibMyLecture, forCellReuseIdentifier: "MyLectureTVCell")
        myLectureTableView.allowsSelection = true
    }
    

    
}

extension MyLectureVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "OnOffLineTVCell", for: indexPath) as! OnOffLineTVCell
            
            return cell
        } else {
            let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "MyLectureTVCell", for: indexPath) as! MyLectureTVCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let aa = self.storyboard?.instantiateViewController(withIdentifier: "VoteVC") as! VoteVC
//        self.present(aa, animated: true, completion: nil)
//        let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "MyLectureTVCell", for: indexPath) as! MyLectureTVCell
//        cell.voteButton.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
