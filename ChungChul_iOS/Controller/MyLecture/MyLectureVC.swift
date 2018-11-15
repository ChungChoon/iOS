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
    
    let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
    
    // Data Variable
    var myLectureListDataFromServer: MyLectureData?
    var onlineDataList: [MyLectureVO]?
    var offlineDataList: [MyLectureVO]?
    var detailLectureDataFromServer: LectureDetailData?
    
    // Variable
    var ud = UserDefaults.standard
    var evaluationPointText: String = ""
    var evaluationPointIndex: Int = 0
    var onOffFlag: Int = 1
    
    @IBAction func unwindToMyLecture(segue:UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        callMyLectureDataFromServer()
        navigationBarSetting(title: "나의 강의", isTranslucent: false)
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Get Farmer My Lecture"{
            myLectureListDataFromServer = resultData as? MyLectureData
            onlineDataList = myLectureListDataFromServer?.onlineData
            offlineDataList = myLectureListDataFromServer?.offlineData
            checkNoData(onOffFlag)
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
    
    @objc func myLectureFlagNoti(notification: NSNotification){
        onOffFlag = gino(notification.userInfo!["flag"] as? Int)
        checkNoData(onOffFlag)
        myLectureTableView.reloadData()
    }
    
    // Add Observer Notification
    fileprivate func addObserverNotification() {
        NotificationCenter.default.addObserver(self,selector: #selector(myLectureFlagNoti(notification:)),name: .myLectureFlagNoti,object: nil)
    }
}

extension MyLectureVC {
    
    // Evaluate Button Action Selector
    @objc func evaluateButtonAction(_ sender: UIButton){
        let evaluationVC = self.storyboard?.instantiateViewController(withIdentifier: "EvaluationVC") as! EvaluationVC
        evaluationVC.lecturePk = sender.tag
        self.navigationController?.pushViewController(evaluationVC, animated: true)
    }
    
    // Present DetailVC with Data by LecturePk
    fileprivate func presentDetailVCWithData() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = main.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.detailData = detailLectureDataFromServer?.lectureData
        detailVC.reviewData = detailLectureDataFromServer?.reviewData
        detailVC.curriculumData = detailLectureDataFromServer?.curriculumData
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
        myLectureTableView.tableFooterView = UIView(frame: CGRect.zero)
        myLectureTableView.tableHeaderView = UIView(frame: CGRect.zero)
        myLectureTableView.delegate = self
        myLectureTableView.dataSource = self
        myLectureTableView.reloadData()
    }
    
    fileprivate func setNoDataLabel(){
        view.addSubview(noDataLabel)
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        noDataLabel.font = UIFont(name: "NotoSansCJKkr-Bold", size: 30)
        noDataLabel.textAlignment = .center
        noDataLabel.text = "신청 강의가 없습니다."
        noDataLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    fileprivate func checkNoData(_ flag: Int){
        if flag == 0{
            if onlineDataList == nil {
                setNoDataLabel()
            } else {
                noDataLabel.removeFromSuperview()
            }
        } else {
            if offlineDataList == nil {
                setNoDataLabel()
            } else {
                noDataLabel.removeFromSuperview()
            }
        }
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
            return branchDataByFlag()
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
        if onOffFlag == 0 {
            let index = onlineDataList![indexPath.row]
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
        } else {
            let index = onlineDataList![indexPath.row]
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
    }
    
    fileprivate func onofflineToggleButtonSectionCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "OnOffLineTVCell", for: indexPath) as! OnOffLineTVCell
        print(cell.flag)
        return cell
    }
    
    fileprivate func myLectureListSectionCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = myLectureTableView.dequeueReusableCell(withIdentifier: "MyLectureTVCell", for: indexPath) as! MyLectureTVCell
        if onOffFlag == 0{
            setOnlineDataCell(indexPath, cell)
        } else {
            setOfflineDataCell(indexPath, cell)
        }
        return cell
    }
    
    fileprivate func setOnlineDataCell(_ indexPath: IndexPath, _ cell: MyLectureTVCell) {
        let index = onlineDataList![indexPath.row]
        cell.typeButton.typeButtonTextSetting(cell.typeButton, gino(index.kind))
        cell.evaluateButton.tag = gino(index.lecturePk)
        cell.lectureImageView.sd_setImage(with: URL(string: gsno(index.farmImg)), placeholderImage: UIImage())
        cell.lectureTitleLabel.text = gsno(index.title)
        cell.farmNameLabel.text = gsno(index.farmName)
        cell.termLabel.text = gsno(index.startDate) + " ~ " + gsno(index.endDate)
        cell.lectureCountLabel.text = "강의 \(gino(index.attendCnt))/\(gino(index.curriculumCount))개 출석완료"
        cell.lectureTotalCountLabel.text = "총 \(gino(index.curriculumCount))회"
        cell.farmAddressLabel.text = gsno(index.place)
        
        let progressPercent = (Double(gino(index.attendCnt)) / Double(gino(index.curriculumCount))).roundToPlaces(places: 1)
        cell.lectureProgressBar.progress = Float(progressPercent)
        cell.countRateLabel.text = "\(progressPercent*100)%"
        if gino(index.state) == 1{
            cell.evaluateButton.isHidden = true
        } else {
            cell.evaluateButton.isHidden = false
            cell.evaluateButton.addTarget(self, action: #selector(evaluateButtonAction), for: .touchUpInside)
        }
    }
    
    fileprivate func setOfflineDataCell(_ indexPath: IndexPath, _ cell: MyLectureTVCell) {
        let index = offlineDataList![indexPath.row]
        cell.typeButton.typeButtonTextSetting(cell.typeButton, gino(index.kind))
        cell.evaluateButton.tag = gino(index.lecturePk)
        cell.lectureImageView.sd_setImage(with: URL(string: gsno(index.farmImg)), placeholderImage: UIImage())
        cell.lectureTitleLabel.text = gsno(index.title)
        cell.farmNameLabel.text = gsno(index.farmName)
        cell.termLabel.text = gsno(index.startDate) + " ~ " + gsno(index.endDate)
        cell.lectureCountLabel.text = "강의 \(gino(index.attendCnt))/\(gino(index.curriculumCount))개 출석완료"
        cell.lectureTotalCountLabel.text = "총 \(gino(index.curriculumCount))회"
        cell.farmAddressLabel.text = gsno(index.place)
        
        let progressPercent = (Double(gino(index.attendCnt)) / Double(gino(index.curriculumCount))).roundToPlaces(places: 1)
        cell.lectureProgressBar.progress = Float(progressPercent)
        cell.countRateLabel.text = "\(progressPercent*100)%"
        if gino(index.state) == 1{
            cell.evaluateButton.isHidden = true
        } else {
            cell.evaluateButton.isHidden = false
            cell.evaluateButton.addTarget(self, action: #selector(evaluateButtonAction), for: .touchUpInside)
        }
    }
    
    fileprivate func branchDataByFlag() -> Int {
        if onOffFlag == 0{
            if onlineDataList != nil {
                return (onlineDataList?.count)!
            } else {
                return 1
            }
        } else {
            if offlineDataList != nil {
                return (offlineDataList?.count)!
            } else {
                return 1
            }
        }
    }
}
