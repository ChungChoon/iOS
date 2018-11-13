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

    // UI IBOutlet Variable
    @IBOutlet var myLectureTableView: UITableView!
    
    // Data Variable
    var myLectureListDataFromServer: [MyLectureVO]?
    var detailLectureDataFromServer: LectureDetailData?
    
    // Variable
    var ud = UserDefaults.standard
    var lecturePk: Int?
    var evaluationPointText: String = ""
    var evaluationPointIndex: Int = 0
    
    @IBAction func unwindToMyLecture(segue:UIStoryboardSegue) {
        callMyLectureDataFromServer()
        myLectureTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callMyLectureDataFromServer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationBarSetting(title: "나의 강의", isTranslucent: false)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Get Farmer My Lecture"{
            myLectureListDataFromServer = resultData as? [MyLectureVO]
            myLectureListDataFromServer = myLectureListDataFromServer?.reversed()
            tableViewSetting()
        } else if code == "Success Get Lecture Detail"{
            detailLectureDataFromServer = resultData as? LectureDetailData
            presentDetailVCWithData()
        } else {
            simpleAlert(title: "오류", msg: "개발자에게 문의하세요.")
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }
}

extension MyLectureVC {
    
    // Evaluate Button Action Selector
    @objc func evaluateButtonAction(){
        let evaluationVC = self.storyboard?.instantiateViewController(withIdentifier: "EvaluationVC") as! EvaluationVC
        evaluationVC.lecturePk = lecturePk
        self.navigationController?.pushViewController(evaluationVC, animated: true)
    }
    
    // Present DetailVC with Data by LecturePk
    fileprivate func presentDetailVCWithData() {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.detailData = detailLectureDataFromServer?.lectureData
        detailVC.reviewData = detailLectureDataFromServer?.reviewData
        detailVC.evaluationPointText = evaluationPointText
        detailVC.evaluationPointIndex = evaluationPointIndex
        self.present(detailVC, animated: false, completion: nil)
    }
    
    // Call My Lecture Data From Server
    fileprivate func callMyLectureDataFromServer() {
        let model = MyLectureModel(self)
        model.callMyLectureList(token: gsno(ud.string(forKey: "token")))
    }
    
    fileprivate func tableViewSetting() {
        let nibMyLecture = UINib(nibName: "MyLectureTVCell", bundle: nil)
        myLectureTableView.register(nibMyLecture, forCellReuseIdentifier: "MyLectureTVCell")
        myLectureTableView.delegate = self
        myLectureTableView.dataSource = self
        myLectureTableView.reloadData()
    }
}

//MARK: TableView Delegate and DataSource
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return onofflineToggleButtonSectionCell(indexPath)
        } else if indexPath.section == 1 {
            return myLectureListSectionCell(indexPath)
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        networkDetailDataFromServer(indexPath)
    }
    
    fileprivate func networkDetailDataFromServer(_ indexPath: IndexPath) {
        let index = myLectureListDataFromServer![indexPath.row]
        let lecturePk = gino(index.lecturePk)
        let token = gsno(UserDefaults.standard.string(forKey: "token"))
        let model = LectureModel(self)
        DispatchQueue.global(qos: .utility).async {
            self.evaluationPointIndex = self.view.getEvaluationAveragePoint(lecturePk)
            self.evaluationPointText = self.view.getEvaluationAveragePointText(lecturePk)
            DispatchQueue.main.async {
                model.callLectureDetail(lectureId: lecturePk, token: token)
            }
        }
    }
    
    fileprivate func onofflineToggleButtonSectionCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "OnOffLineTVCell", for: indexPath) as! OnOffLineTVCell
        return cell
    }
    
    fileprivate func myLectureListSectionCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "MyLectureTVCell", for: indexPath) as! MyLectureTVCell
        let index = myLectureListDataFromServer![indexPath.row]
        lecturePk = index.lecturePk
        
        cell.lectureImageView.sd_setImage(with: URL(string: gsno(index.farmImg)), placeholderImage: UIImage())
        cell.lectureTitleLabel.text = gsno(index.title)
        cell.farmNameLabel.text = gsno(index.farmName)
        cell.termLabel.text = gsno(index.startDate) + " ~ " + gsno(index.endDate)
        cell.lectureCountLabel.text = "강의 \(gino(index.attendCnt))/00개 출석완료"
        if gino(index.state) == 1{
            cell.evaluateButton.isHidden = true
        } else {
            cell.evaluateButton.isHidden = false
            cell.evaluateButton.addTarget(self, action: #selector(evaluateButtonAction), for: .touchUpInside)
        }
        return cell
    }
}
