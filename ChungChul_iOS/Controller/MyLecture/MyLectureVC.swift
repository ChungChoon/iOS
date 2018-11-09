//
//  MyLectureVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 24/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import SDWebImage

class MyLectureVC: UIViewController, NetworkCallback {

    @IBOutlet var myLectureTableView: UITableView!
    
    var myLectureListDataFromServer: [MyLectureVO]?
    var ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibMyLecture = UINib(nibName: "MyLectureTVCell", bundle: nil)
        myLectureTableView.register(nibMyLecture, forCellReuseIdentifier: "MyLectureTVCell")
        
        let model = MyLectureModel(self)
        model.callMyLectureList(token: gsno(ud.string(forKey: "token")))
        print(gsno(ud.string(forKey: "token")))
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Get Farmer My Lecture"{
            myLectureListDataFromServer = resultData as? [MyLectureVO]

            myLectureTableView.delegate = self
            myLectureTableView.dataSource = self
            myLectureTableView.reloadData()
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
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
            if myLectureListDataFromServer == nil{
                return 1
            } else {
                return (myLectureListDataFromServer?.count)!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "OnOffLineTVCell", for: indexPath) as! OnOffLineTVCell
            
            return cell
        } else if indexPath.section == 1 {
            let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "MyLectureTVCell", for: indexPath) as! MyLectureTVCell
            let index = myLectureListDataFromServer![indexPath.row]
            
            cell.lectureImageView.sd_setImage(with: URL(string: gsno(index.farmImg)), placeholderImage: UIImage())
            cell.lectureTitleLabel.text = gsno(index.title)
            cell.farmNameLabel.text = gsno(index.farmName)
            cell.termLabel.text = gsno(index.startDate) + " ~ " + gsno(index.endDate)
            cell.lectureCountLabel.text = "강의 \(gino(index.attendCnt))/00개 출석완료"
            return cell
        } else {
            return UITableViewCell()
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
