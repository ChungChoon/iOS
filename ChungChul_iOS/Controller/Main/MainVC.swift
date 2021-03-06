//
//  MainVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 16/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import Lottie

extension Notification.Name{
    static let gotoDetail = Notification.Name("gotoDetail")
    static let finishDownloadKlaytnData = Notification.Name("finishDownloadKlaytnData")
    static let myLectureFlagNoti = Notification.Name("myLectureFlagNoti")
}

class MainVC: UIViewController, NetworkCallback {
    
    // UI IBOutlet variable
    @IBOutlet var lectureTableView: UITableView!
    let animationView = LOTAnimationView(name: "loading")
    let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    // Data variable
    var lectureListDataFromServer: HomeData?
    var popularData: [PopularDataVO]?
    var offlineData: [OfflineDataVO]?
    var onlineData: [OnlineDataVO]?
    var detailLectureDataFromServer: LectureDetailData?
    
    // Variable
    var lecturePk: Int = 0
    var evaluationPointText: String = ""
    var evaluationPointIndex: Int = 0
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting(title: "강의 목록", isTranslucent: false)
        tableViewSetting()
        addObserverNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callHomeDataFromServer()
        indicatorViewSetting(indicatorView, animationView)
    }
    
    //MARK: Networking Result From Server Function
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Get Information"{
            lectureListDataFromServer = resultData as? HomeData
            popularData = lectureListDataFromServer?.popular
            offlineData = lectureListDataFromServer?.offline
            onlineData = lectureListDataFromServer?.online
            
            lectureTableView.delegate = self
            lectureTableView.dataSource = self
            lectureTableView.reloadData()
            
        } else if code == "Success Get Lecture Detail"{
            detailLectureDataFromServer = resultData as? LectureDetailData
            
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            detailVC.detailData = detailLectureDataFromServer?.lectureData
            detailVC.reviewData = detailLectureDataFromServer?.reviewData
            detailVC.curriculumData = detailLectureDataFromServer?.curriculumData
            detailVC.evaluationPointText = evaluationPointText
            detailVC.evaluationPointIndex = evaluationPointIndex
            self.present(detailVC, animated: false, completion: nil)
            
        } else {
            simpleAlert(title: "오류", msg: "개발자에게 문의하세요.")
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인하세요.")
    }

    //MARK: Notification Function
    @objc func gotoDetail(notification: NSNotification){
        lecturePk = gino(notification.userInfo!["lecturePk"] as? Int)
        evaluationPointText = gsno(notification.userInfo!["evaluationPointText"] as? String)
        evaluationPointIndex = gino(notification.userInfo!["evaluationPointIndex"] as? Int)
        
        let model = LectureModel(self)
        model.callLectureDetail(lectureId: lecturePk, token: gsno(UserDefaults.standard.string(forKey: "token")))
    }
    
    @objc func finishDownloadKlaytnData(notification: NSNotification){
        DispatchQueue.main.async {
            self.animationView.stop()
            self.indicatorView.removeFromSuperview()
        }
    }
}

extension MainVC {
    
    // Call Home Lecture Data From Server Function
    fileprivate func callHomeDataFromServer() {
        let model = LectureModel(self)
        model.callLectureList(token: gsno(UserDefaults.standard.string(forKey: "token")))
    }
    
    // TableView Setting and XIB Register
    fileprivate func tableViewSetting() {
        lectureTableView.tableFooterView = UIView(frame: CGRect.zero)
        lectureTableView.tableHeaderView = UIView(frame: CGRect.zero)
        lectureTableView.allowsSelection = false
        let nibLectureList = UINib(nibName: "LectureListCell", bundle: nil)
        lectureTableView.register(nibLectureList, forCellReuseIdentifier: "LectureListCell")
    }
    
    // Add Observer Notification
    fileprivate func addObserverNotification() {
        NotificationCenter.default.addObserver(self,selector: #selector(gotoDetail(notification:)),name: .gotoDetail,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finishDownloadKlaytnData(notification:)), name: .finishDownloadKlaytnData, object: nil)
    }
}

//MARK: TableView Delegate and DataSource
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return popularLectureSectionCell(indexPath)
        case 1:
            return lectureListSectionCell(indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func popularLectureSectionCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = lectureTableView.dequeueReusableCell(withIdentifier: "PopularLectureTVCell", for: indexPath) as! PopularLectureTVCell
        if popularData != nil {
            cell.popularData = popularData
            cell.getEvaluationDataOnKlaytn()
        }
        return cell
    }
    
    fileprivate func lectureListSectionCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = lectureTableView.dequeueReusableCell(withIdentifier: "LectureListCell", for: indexPath) as! LectureListCell
        if indexPath.row == 0{
            offlineSectionCell(cell)
        } else {
            onlineSectionCell(cell)
        }
        return cell
    }
    
    fileprivate func offlineSectionCell(_ cell: LectureListCell) {
        cell.sectionLabel.text = "오프라인 실습 교육"
        if offlineData != nil {
            cell.offlineData = offlineData
        }
    }
    
    fileprivate func onlineSectionCell(_ cell: LectureListCell) {
        cell.sectionLabel.text = "온라인 실습 교육"
        if onlineData != nil {
            cell.onlineData = onlineData
        }
    }
}
