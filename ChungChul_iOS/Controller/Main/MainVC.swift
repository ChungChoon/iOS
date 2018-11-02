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
    
    var resposeData: HomeDataModel?
    var popularData: [PopularDataVO]?

    var row : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        lectureTableView.tableFooterView = UIView(frame: CGRect.zero)
        lectureTableView.tableHeaderView = UIView(frame: CGRect.zero)
        let model = LectureModel(self)
        model.totalLectureCall(token: gsno(UserDefaults.standard.string(forKey: "token")))

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
        navigationBarSetting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.removeGestureRecognizer(titleTapGestureRecognizer)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Get Information"{
            resposeData = resultData as? HomeDataModel
            popularData = resposeData?.popular
            lectureTableView.delegate = self
            lectureTableView.dataSource = self
            lectureTableView.reloadData()
        } else {
            simpleAlert(title: "오류", msg: "개발자에게 문의하세요.")
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인하세요.")
    }

    @objc func gotoDetail(notification: NSNotification){
        row = gino(notification.userInfo!["row"] as? Int)
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.data = popularData![row]
        self.present(detailVC, animated: false, completion: nil)
    }
    
    @objc func gotoMain(notification: NSNotification){

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
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = lectureTableView.dequeueReusableCell(withIdentifier: "PopularLectureTVCell", for: indexPath) as! PopularLectureTVCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            if popularData != nil {
                cell.popularData = popularData
            }
            return cell
            
        } else {
            let cell = lectureTableView.dequeueReusableCell(withIdentifier: "LectureListCell", for: indexPath) as! LectureListCell
            cell.sectionLabel.text = "작물 재배 실습 교육"
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            return cell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
