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

class DetailVC: UIViewController, NetworkCallback {
    
    let abi = "[{\"constant\": true,\"inputs\": [],\"name\": \"getLectureCount\",\"outputs\": [{\"name\": \"lectureCount\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureID\",\"type\": \"uint256\"}],\"name\": \"voteLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"lectureCreate\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"name\": \"getLectureTotalCost\",\"outputs\": [{\"name\": \"totalLectureCost\",\"type\": \"uint256\"},{\"name\": \"preparation_point\",\"type\": \"uint256\"},{\"name\": \"content_point\",\"type\": \"uint256\"},{\"name\": \"proceed_point\",\"type\": \"uint256\"},{\"name\": \"interaction_point\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"purchaseLecture\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"owner\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"acceptAdmin\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"payBalance\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"lectureIDs\",\"outputs\": [{\"name\": \"\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"_studentAddress\",\"type\": \"address\"}],\"name\": \"getStudentIndexNumber\",\"outputs\": [{\"name\": \"studentIndex\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureID\",\"outputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"name\": \"calculateLecturePoint\",\"outputs\": [{\"name\": \"totalPoint\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"transferOwnership\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"inputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"id\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"teacher\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"CreatingLecture\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"lectureID\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"voter\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"votes\",\"type\": \"uint256\"}],\"name\": \"Voting\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"previousOwner\",\"type\": \"address\"},{\"indexed\": true,\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"OwnershipTransferred\",\"type\": \"event\"}]"

    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var applyButton: UIButton!
    
    var aaa = ["123", "2323" , "32323", "1111"]
    
    var data: PopularDataVO?
    
    var bip32keystore:BIP32Keystore?
    var keystoremanager:KeystoreManager?
    var contract:web3.web3contract?
    var web3Klaytn:web3?
    var userAddress: String?
    var ethAdd: EthereumAddress?
    
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
        applyButton.addTarget(self, action: #selector(applyButtonAction), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        headerViewSetting()
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "success to apply lecture"{
            applyButton.isHidden = true
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }

    
    @objc func applyButtonAction() {
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = userDir+"/keystore/"
        keystoremanager =  KeystoreManager.managerForPath(path, scanForHDwallets: true, suffix: "json")
        self.web3Klaytn?.addKeystoreManager(self.keystoremanager)
        self.bip32keystore = self.keystoremanager?.bip32keystores[0]
        userAddress = self.bip32keystore?.addresses?.first?.address
        
        let web3 = Web3.new(URL(string: "http://localhost:8551")!)
        
        
        
        let contractAddress = EthereumAddress("0xc936be85bfdd3d88fdc3134b0b26b835506f4b7a")!
        var options = Web3Options.defaultOptions()
//        options.gasPrice = Web3.Utils.parseToBigUInt("100", units: .wei)
//        options.gasLimit = Web3.Utils.parseToBigUInt("300000000", units: .wei)
//        options.gasLimit = BigUInt(100000000000000)
//        options.value = Web3.Utils.parseToBigUInt("\(gino(data?.price))", units: .eth)
        options.value = Web3.Utils.parseToBigUInt("10", units: .eth)
//        options.value = BigUInt(Int(gino(data?.price)) * 1000000000000000000)
        options.from = bip32keystore!.addresses![0]
        let testParameters = [BigUInt(gino(data?.lecturePk))] as [AnyObject]
        let transactionResult = web3!.contract(abi, at: contractAddress, abiVersion: 2)?.method("purchaseLecture", parameters: testParameters, options: options)
        let gasEstimateResult = transactionResult!.estimateGas(options: nil)
        guard case .success(let gasEstimate) = gasEstimateResult else {return}
        var optionsWithCustomGasLimit = Web3Options()
        optionsWithCustomGasLimit.gasLimit = gasEstimate
        let tokenTransferResult = transactionResult?.send(password: "doa01092", options: optionsWithCustomGasLimit)
        print(tokenTransferResult)
        // Create the alert controller
        let alertController = UIAlertController(title: "신청 완료", message: "수강료가 결제되었습니다.", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }

        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
//        //수강신청 api 콜
//        let model = LectureModel(self)
//        model.purchaseLectureModel(token: gsno(UserDefaults.standard.string(forKey: "token")), lecture_id: gino(data?.lecture_pk))
    }
}

extension DetailVC {
    
    func headerViewSetting(){
        view.addSubview(headerView)
        typeImageViewSetting(headerView.typeButton)
        typeTextButtonSetting(headerView.typeButton, gino(data?.kind))
        headerView.lectureTitleLabel.text = gsno(data?.title)
        headerView.teacherNameLabel.text = gsno(data?.name)
        headerView.farmNameLabel.text = gsno(data?.farmName)
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
            cell.purchaseButton.setTitle("\(gino(data?.price)) KLAY", for: .normal)
            cell.purchaseButton.layer.masksToBounds = true
            cell.purchaseButton.layer.cornerRadius = 15
            cell.purchaseButton.layer.borderWidth = 1.0
            cell.purchaseButton.layer.borderColor = #colorLiteral(red: 0.3616529107, green: 0.554502666, blue: 0.8968388438, alpha: 1)
            
            cell.typeLabel.text = "오프라인"
            cell.termLabel.text = "\(gsno(data?.startDate)) ~ \(gsno(data?.endDate))"
            cell.placeLabel.text = gsno(data?.place)
            cell.costLabel.text = "\(gino(data?.price)) KLAY"
            return cell
        case 1:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "IntroduceTVCell") as! IntroduceTVCell
            cell.titleLabel.text = gsno(data?.title)
            cell.detailLabel.text = gsno(data?.intro)
            return cell
        case 2:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "PlanTVCell") as! PlanTVCell
            
            
            
            return cell
        case 3:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "TeacherTVCell") as! TeacherTVCell
            
//            if gino(data?.farm_career) == 0 {
//                cell.introduceLabel.text = "농사 경력 5년 미만입니다^^"
//            } else if gino(data?.farm_career) == 1{
//                cell.introduceLabel.text = "농사 경력 10년 미만입니다^^"
//            } else {
//                cell.introduceLabel.text = "농사 경력 10년 이상입니다^^"
//            }
            
            return cell
        case 4:
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "CommentTVCell") as! CommentTVCell
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
