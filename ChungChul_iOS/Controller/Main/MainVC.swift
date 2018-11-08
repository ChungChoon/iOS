//
//  MainVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 16/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

extension Notification.Name{
    static let gotoDetail = Notification.Name("gotoDetail")
    static let gotoMain = Notification.Name("gotoMain")
}

class MainVC: UIViewController, NetworkCallback {
    
    @IBOutlet var lectureTableView: UITableView!
    
    var titleTapGestureRecognizer: UITapGestureRecognizer!
    
    var lectureListDataFromServer: HomeDataModel?
    var popularData: [PopularDataVO]?
    var offlineData: [OfflineDataVO]?
    var onlineData: [OnlineDataVO]?
    
    var detailLectureDataFromServer: LectureDetailData?

    var lecturePk : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        lectureTableView.tableFooterView = UIView(frame: CGRect.zero)
        lectureTableView.tableHeaderView = UIView(frame: CGRect.zero)
        let model = LectureModel(self)
        model.callLectureList(token: gsno(UserDefaults.standard.string(forKey: "token")))

        lectureTableView.allowsSelection = false
        let nibLectureList = UINib(nibName: "LectureListCell", bundle: nil)
        lectureTableView.register(nibLectureList, forCellReuseIdentifier: "LectureListCell")
        navigationBarSetting()
        
        NotificationCenter.default.addObserver(self,selector: #selector(gotoDetail(notification:)),name: .gotoDetail,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gotoMain(notification:)), name: .gotoMain, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(titleTapAction(_:)))
        self.navigationController?.navigationBar.addGestureRecognizer(titleTapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.removeGestureRecognizer(titleTapGestureRecognizer)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Get Information"{
            lectureListDataFromServer = resultData as? HomeDataModel
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
            
            self.present(detailVC, animated: false, completion: nil)
        } else {
            simpleAlert(title: "오류", msg: "개발자에게 문의하세요.")
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인하세요.")
    }

    @objc func gotoDetail(notification: NSNotification){
        lecturePk = gino(notification.userInfo!["lecturePk"] as? Int)

        let model = LectureModel(self)
        model.callLectureDetail(lectureId: lecturePk, token: gsno(UserDefaults.standard.string(forKey: "token")))
    }
    
    @objc func gotoMain(notification: NSNotification){

    }
}

extension MainVC {
    @objc func titleTapAction(_ theObject: AnyObject) {
        let typeListVC = self.storyboard?.instantiateViewController(withIdentifier: "TypeListVC") as! TypeListVC
        typeListVC.delegate = self
        self.present(typeListVC, animated: true, completion: nil)
    }
    
    func navigationBarSetting(){
        self.title = "실습 교육 전체"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Bold", size: 24)!]
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension MainVC: TypeSaveDelegate {
    func updateType(_ typeList: [String]) {
        print(typeList)
        var titleText = ""
        
        for type in typeList {
            titleText += type + " "
        }
        self.title = titleText
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
        
        switch indexPath.section {
        case 0:
            let cell = lectureTableView.dequeueReusableCell(withIdentifier: "PopularLectureTVCell", for: indexPath) as! PopularLectureTVCell
            if popularData != nil {
                cell.popularData = popularData
            }
            return cell
        case 1:
            let cell = lectureTableView.dequeueReusableCell(withIdentifier: "LectureListCell", for: indexPath) as! LectureListCell
            if indexPath.row == 0{
                cell.sectionLabel.text = "오프라인 실습 교육"
                if offlineData != nil {
                    cell.offlineData = offlineData
                }
            } else {
                cell.sectionLabel.text = "온라인 실습 교육"
                if onlineData != nil {
                    cell.onlineData = onlineData
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
