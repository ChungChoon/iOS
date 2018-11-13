//
//  DetailVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 25/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift
import BigInt
import SDWebImage

class DetailVC: UIViewController, NetworkCallback {

    // UI IBOutlet Variable
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var applyButton: UIButton!
    
    // Data Variable
    var detailData: LectureDetailDataVO?
    var reviewData: [LectureReviewDataVO]?
    
    // Caver Singleton Instance Variable
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    
    // Variable
    var evaluationPointText: String = ""
    var evaluationPointIndex: Int = 0
    var rateViewIndex: Int?
    let screenSizeWidth = UIScreen.main.bounds.size.width
    
    // HeaderView Variable Setting Using Closure
    let headerView: HeaderView = {
        let view = HeaderView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 274)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateViewIndex = view.getRateViewIndexByEvaluationPoint(evaluationPointIndex)
        headerViewSetting()
        tableViewSetting()
        checkTokenExists()
        checkAlreadyBuy()
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "success to apply lecture"{
            applyButton.removeTarget(self, action: #selector(applyButtonAction), for: .touchUpInside)
            applyButton.setTitle("신청완료", for: .normal)
            applyButton.isEnabled = false
        } else {
            let msg = resultData as! String
            simpleAlert(title: "서버 오류", msg: msg)
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }
}

extension DetailVC {
    
    // Back Button Action Selector
    @objc func dismissButtonAction(){
        dismiss(animated: true, completion: nil)
    }
    
    // Login Alert View Accept Button Action Selector
    @objc func loginButtonAction(){
        let loginAlertView = LoginAlertView(frame: UIApplication.shared.keyWindow!.frame)
        UIApplication.shared.keyWindow!.addSubview(loginAlertView)
    }
    
    // Purchase Lecture Button Action Selector
    @objc func applyButtonAction() {
        let token = gsno(UserDefaults.standard.string(forKey: "token"))
        let lectureId = gino(detailData?.lecturePk)
        let price = gino(detailData?.price)
        
        if isPurchasingLectureTransaction() { // Transaction 성공 시
            presentSuccessPurchasingAlertView()
            let model = LectureModel(self)
            model.purchaseLectureModel(token: token, lecture_id: lectureId, price: price)
            
        } else { // Transaction 실패 시
            simpleAlert(title: "구매 실패", msg: "KLAY가 부족합니다!")
        }
    }
    
    // Present Purchasing Success AlertView when Transaction Success
    fileprivate func presentSuccessPurchasingAlertView() {
        let alertController = UIAlertController(title: "신청 완료", message: "수강료가 결제되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // HeaderView Setting
    fileprivate func headerViewSetting(){
        view.addSubview(headerView)
        headerView.typeButtonSetting(headerView.typeButton)
        headerView.typeButtonTextSetting(headerView.typeButton, gino(detailData?.kind))
        headerView.lectureTitleLabel.text = gsno(detailData?.title)
        headerView.teacherNameLabel.text = gsno(detailData?.name)
        headerView.farmNameLabel.text = gsno(detailData?.farmName)
        headerView.backImageView.sd_setImage(with: URL(string: gsno(detailData?.farmImg)), placeholderImage: UIImage())
        headerView.teacherImageView.sd_setImage(with: URL(string: gsno(detailData?.img)), placeholderImage: UIImage(named: "ic_people36"))
        headerView.dismissButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)
        
    }
    
    // TableView Setting
    fileprivate func tableViewSetting() {
        detailTableView.separatorInset = UIEdgeInsets(top: 0, left: screenSizeWidth, bottom: 0, right: 0)
        detailTableView.contentInset = UIEdgeInsets(top: 274, left: 0, bottom: 0, right: 0)
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    // Check Whether User has Already Purchased a Lecture
    fileprivate func checkAlreadyBuy() {
        if gino(detailData?.checkBuy) == 1{
            applyButton.setTitle("신청완료", for: .normal)
            applyButton.isEnabled = false
            applyButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    // Check Whether User was Logined
    fileprivate func checkTokenExists() {
        applyButton.isEnabled = true
        if UserDefaults.standard.string(forKey: "token") == nil {
            applyButton.setTitle("로그인이 필요합니다.", for: .normal)
            applyButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
            applyButton.backgroundColor = #colorLiteral(red: 1, green: 0.6348013282, blue: 0, alpha: 1)
        } else {
            applyButton.setTitle("수강신청", for: .normal)
            applyButton.addTarget(self, action: #selector(applyButtonAction), for: .touchUpInside)
            applyButton.backgroundColor = #colorLiteral(red: 0.3616529107, green: 0.554502666, blue: 0.8968388438, alpha: 1)
        }
    }
    
    // Return Boolean Value about Purchasing Transaction Status
    fileprivate func isPurchasingLectureTransaction() -> Bool{
        do {
            let caver = instance.caver
            let ABI = instance.contractABI
            let contractAddress = instance.contractAddress
            let passwd = gsno(UserDefaults.standard.string(forKey: "password"))
            let lecturePrice = gino(detailData?.price)
            let lectureNumber = BigUInt(gino(detailData?.lecturePk))
            
            // Option Setting
            var options = Web3Options.default
            options.value = Web3.Utils.parseToBigUInt("\(lecturePrice)", units: .eth)
            options.gasLimit = BigUInt(701431)
            options.from = instance.userAddress
            
            // Parameter Setting
            let lectureNumberParameter = [lectureNumber] as [AnyObject]
            
            // Estimated Gas
            let estimatedGas = try caver.contract(ABI, at: contractAddress).method("purchaseLecture", parameters: lectureNumberParameter, options: options).estimateGas(options: nil)
            options.gasLimit = estimatedGas
            
            // Transaction Setting
            let transactionResult = try caver.contract(ABI, at: contractAddress).method("purchaseLecture", parameters: lectureNumberParameter, options: options)
            print(transactionResult.transaction)
            
            // Transaction Send
            let sendingResult = try transactionResult.send(password: passwd)
            print(sendingResult.transaction)
            
            return true
        } catch{
            print("You don't have enough KLAY!")
            print(error.localizedDescription)
            return false
        }
    }
}

//MARK: TableView Delegate and DataSource
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Stretch HeaderView Delegate Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 274 - (scrollView.contentOffset.y + 274)
        let height = min(max(y, 0), 600)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return informationSectionCell()
        case 1:
            return introduceSectionCell()
        case 2:
            return planSectionCell()
        case 3:
            return teacherIntroduceSectionCell()
        case 4:
            return reviewSectionCell()
        default:
            return UITableViewCell()
        }
    }

    fileprivate func informationSectionCell() -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "InformationTVCell") as! InformationTVCell
        cell.purchaseButton.setTitle("\(gino(detailData?.price)) KLAY", for: .normal)
        cell.typeLabel.text = "오프라인"
        cell.termLabel.text = gsno(detailData?.startDate) + " ~ " + gsno(detailData?.endDate)
        cell.placeLabel.text = gsno(detailData?.place)
        cell.costLabel.text = "\(gino(detailData?.price)) KLAY"
        cell.voteCountLabel.text = "총 \(gino(reviewData?.count))개의 평가"
        cell.voteRateLabel.text = evaluationPointText
        
        if rateViewIndex != nil{
            for i in 0...gino(rateViewIndex) {
                cell.rateView.ratingViewArray[i].backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            }
        } else {
            cell.rateView.isHidden = true
        }
        
        return cell
    }
    
    fileprivate func introduceSectionCell() -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "IntroduceTVCell") as! IntroduceTVCell
        cell.titleLabel.text = gsno(detailData?.title)
        cell.detailLabel.text = gsno(detailData?.intro)
        return cell
    }
    
    fileprivate func planSectionCell() -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "PlanTVCell") as! PlanTVCell
        return cell
    }
    
    fileprivate func teacherIntroduceSectionCell() -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "TeacherTVCell") as! TeacherTVCell
        return cell
    }
    
    fileprivate func reviewSectionCell() -> UITableViewCell {
        if evaluationPointText != "평가가 없습니다."{
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "CommentTVCell") as! CommentTVCell
            cell.commentCountLabel.text = "\(gino(reviewData?.count))개의 후기가 있습니다!"
            cell.reviewDataFromServer = reviewData
            cell.rateLabel.text = evaluationPointText
            for i in 0...gino(rateViewIndex) {
                cell.rateView.ratingViewArray[i].backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
