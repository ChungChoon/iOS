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

    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var applyButton: UIButton!
    
    var detailData: LectureDetailDataVO?
    var reviewData: [LectureReviewDataVO]?
    
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    
    let headerView: HeaderView = {
        let v = HeaderView()
        v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 274)
        //v.backImageView.image = #imageLiteral(resourceName: "1")
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.contentInset = UIEdgeInsets(top: 274, left: 0, bottom: 0, right: 0)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        tokenCheck()
        checkAlreadyBuy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        headerViewSetting()
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "success to apply lecture"{
            applyButton.removeTarget(self, action: #selector(applyButtonAction), for: .touchUpInside)
            applyButton.setTitle("신청완료", for: .normal)
            applyButton.isEnabled = false
            print("success!")
        } else {
            let msg = resultData as! String
            simpleAlert(title: "서버 오류", msg: msg)
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }
    
    fileprivate func checkAlreadyBuy() {
        if gino(detailData?.checkBuy) == 1{
            applyButton.setTitle("신청완료", for: .normal)
            applyButton.isEnabled = false
            applyButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    fileprivate func tokenCheck() {
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
    
    fileprivate func isPurchaseLectureTransaction() -> Bool{
        do {
            let caver = instance.caver
            let ABI = instance.contractABI
            let contractAddress = instance.contractAddress
            let passwd = gsno(UserDefaults.standard.string(forKey: "password"))
            let lecturePrice = gino(detailData?.price)
            
            // Option Setting
            var options = Web3Options.default
            options.value = Web3.Utils.parseToBigUInt("\(lecturePrice)", units: .eth)
            options.gasLimit = BigUInt(701431)
            options.from = instance.userAddress

            // Parameter Setting
            let lectureNumberParameter = [BigUInt(gino(detailData?.lecturePk))] as [AnyObject]
            
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
            print("Transaction Fail!")
            print(error.localizedDescription)
            return false
        }

    }
    
    fileprivate func successPurchaseLectureAlertController() {
        let alertController = UIAlertController(title: "신청 완료", message: "수강료가 결제되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) {
            UIAlertAction in
//            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func loginButtonAction(){
        let loginAlertView = LoginAlertView(frame: UIApplication.shared.keyWindow!.frame)
        UIApplication.shared.keyWindow!.addSubview(loginAlertView)
    }
    
    @objc func applyButtonAction() {
        let token = gsno(UserDefaults.standard.string(forKey: "token"))
        let lectureId = gino(detailData?.lecturePk)
        let price = gino(detailData?.price)
        
        if isPurchaseLectureTransaction() { // Transaction 성공 시
            successPurchaseLectureAlertController()
            let model = LectureModel(self)
            model.purchaseLectureModel(token: token, lecture_id: lectureId, price: price)
            
        } else { // Transaction 실패 시
            simpleAlert(title: "트랜잭션 실패", msg: "보유 클레이를 확인해주세요!")
        }
    }
}

extension DetailVC {
    
    func headerViewSetting(){
        view.addSubview(headerView)
        typeImageViewSetting(headerView.typeButton)
        typeTextButtonSetting(headerView.typeButton, gino(detailData?.kind))
        headerView.lectureTitleLabel.text = gsno(detailData?.title)
        headerView.teacherNameLabel.text = gsno(detailData?.name)
        headerView.farmNameLabel.text = gsno(detailData?.farmName)
        headerView.backImageView.sd_setImage(with: URL(string: gsno(detailData?.farmImg)), placeholderImage: UIImage())
        headerView.teacherImageView.sd_setImage(with: URL(string: gsno(detailData?.img)), placeholderImage: UIImage(named: "ic_people36"))
        headerView.dismissButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)

    }
    
    @objc func dismissButtonAction(){
         dismiss(animated: true, completion: nil)
    }
    
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "InformationTVCell") as! InformationTVCell
            cell.purchaseButton.setTitle("\(gino(detailData?.price)) KLAY", for: .normal)
            cell.purchaseButton.layer.masksToBounds = true
            cell.purchaseButton.layer.cornerRadius = 15
            cell.purchaseButton.layer.borderWidth = 1.0
            cell.purchaseButton.layer.borderColor = #colorLiteral(red: 0.3616529107, green: 0.554502666, blue: 0.8968388438, alpha: 1)
            
            cell.typeLabel.text = "오프라인"
            cell.termLabel.text = "\(gsno(detailData?.startDate)) ~ \(gsno(detailData?.endDate))"
            cell.placeLabel.text = gsno(detailData?.place)
            cell.costLabel.text = "\(gino(detailData?.price)) KLAY"
            return cell
        case 1:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "IntroduceTVCell") as! IntroduceTVCell
            cell.titleLabel.text = gsno(detailData?.title)
            cell.detailLabel.text = gsno(detailData?.intro)
            return cell
        case 2:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "PlanTVCell") as! PlanTVCell
            return cell
        case 3:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "TeacherTVCell") as! TeacherTVCell
            return cell
        case 4:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "CommentTVCell") as! CommentTVCell
            cell.commentCountLabel.text = "\(gino(reviewData?.count))개의 후기가 있습니다!"
            cell.reviewDataFromServer = reviewData
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 274 - (scrollView.contentOffset.y + 274)
        let height = min(max(y, 0), 600)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
    }
    
}
