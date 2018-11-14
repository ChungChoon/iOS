//
//  EvaluationVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 01/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift
import BigInt

class EvaluationVC: UIViewController, NetworkCallback {

    // UI IBOutlet Variable
    @IBOutlet var evaluationTableView: UITableView!
    @IBOutlet var doneButton: UIButton!
    
    // UI Variable
    var colorArray: [UIColor] = [#colorLiteral(red: 0.3176470588, green: 0.8941176471, blue: 0.6705882353, alpha: 1),#colorLiteral(red: 0.1764705882, green: 0.8666666667, blue: 0.7607843137, alpha: 1),#colorLiteral(red: 0.2862745098, green: 0.8431372549, blue: 0.9176470588, alpha: 1),#colorLiteral(red: 0.2392156863, green: 0.7411764706, blue: 0.8901960784, alpha: 1),#colorLiteral(red: 0.3725490196, green: 0.6078431373, blue: 0.8941176471, alpha: 1)]
    let evaluationTitleArray: [String] = [
        "수업준비",
        "수업내용",
        "진행방식",
        "커뮤니케이션",
        "전체적인 만족도"
        ]
    let evaluationSubjectArray: [String] = [
    "강사가 수업준비에 성실하였나요?",
    "수업 내용에 대해 만족하셨나요?",
    "강사의 강의 진행방식에 대해 만족하셨나요?",
    "강사와 커뮤니케이션이 잘 되었나요?",
    "전체적인 만족도에 대해 입력 해주세요"
    ]
    
    // Data Variable
    var lecturePk: Int?
    var content: String?
    var ud = UserDefaults.standard
    var evaluationValueArray: [Int] = [0,0,0,0,0]
    var reviewCount: Int?
    
    // Klaytn Data Variable
    var evaluationPoint: Int = 0
    var rateViewIndex: Int?
    
    // Caver Singleton Instance Variable
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting(title: "강의평가", isTranslucent: false)
        tableViewSetting()
        addTargetButton()
        getEvaluationDataOnKlaytn()
    }
    
    func evaluateLectureOnKlaytn(){
            let caver = instance.caver
            let ABI = instance.contractABI
            let contractAddress = instance.contractAddress
            let passwd = gsno(UserDefaults.standard.string(forKey: "password"))
            
            // Option Setting
            var options = Web3Options.default
            options.gasLimit = BigUInt(701431)
            options.from = instance.userAddress
            
            let lectureNumber = BigUInt(gino(lecturePk))
            let preparationPoint = BigUInt(gino(evaluationValueArray[0]))
            let contentPoint = BigUInt(gino(evaluationValueArray[1]))
            let proceedPoint = BigUInt(gino(evaluationValueArray[2]))
            let communicationPoint = BigUInt(gino(evaluationValueArray[3]))
            let satisfactionPoint = BigUInt(gino(evaluationValueArray[4]))
            
            // Parameter Setting
            let evaluateParameters = [lectureNumber, preparationPoint, contentPoint, proceedPoint, communicationPoint, satisfactionPoint] as [AnyObject]
            print(evaluateParameters)

            DispatchQueue.global(qos: .utility).async {
                do{
                    // Estimated Gas
                    let estimatedGas = try caver.contract(ABI, at: contractAddress).method("evaluateLecture", parameters: evaluateParameters, options: options).estimateGas(options: nil)
                    options.gasLimit = estimatedGas
                    print(estimatedGas)
                    // Transaction Setting
                    let transactionResult = try caver.contract(ABI, at: contractAddress).method("evaluateLecture", parameters: evaluateParameters, options: options)
                    print(transactionResult.transaction)
                    // Transaction Send
                    let sendingResult = try transactionResult.send(password: passwd)
                    print(sendingResult.transaction)
                    DispatchQueue.main.async {
                        self.networkEvaluateLectureToServer()
                    }
                } catch{
                    print("You don't have enough KLAY!")
                    print(error.localizedDescription)
                }
            }
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "success to evaluate lecture"{
            performSegue(withIdentifier: "unwindToMyLecture", sender: self)
        } else {
            let msg = resultData as! String
            simpleAlert(title: msg, msg: "서버 오류, 개발자에게 문의하세요." )
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }
}

extension EvaluationVC {
    
    @objc func doneButtonAction(){
        evaluateLectureOnKlaytn()
    }
    
    @objc func detectingButtonInCell(_ sender: UIButton){
        let cell = sender.superview?.superview as! EvaluationListTVCell
        let indexPath = self.evaluationTableView.indexPath(for: cell)
        self.evaluationTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        evaluationValueArray[(indexPath?.row)!] = gino(cell.value)
    }
    
    fileprivate func tableViewSetting() {
        evaluationTableView.delegate = self
        evaluationTableView.dataSource = self
    }
    
    fileprivate func addTargetButton() {
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
    }
    
    fileprivate func networkEvaluateLectureToServer() {
        let token = gsno(ud.string(forKey: "token"))
        let model = MyLectureModel(self)
        model.evaluateLecture(token: token, lecture_id: gino(lecturePk), content: gsno(content))
    }
    
    fileprivate func getEvaluationDataOnKlaytn(){
        let lectureNumber = gino(lecturePk)
        DispatchQueue.global(qos: .utility).async {
            self.evaluationPoint = self.view.getEvaluationAveragePoint(lectureNumber)
            DispatchQueue.main.async {
                self.rateViewIndex = self.view.getRateViewIndexByEvaluationPoint(self.evaluationPoint)
                self.evaluationTableView.reloadData()
            }
        }
    }
}

//MARK: TextView Delegate
extension EvaluationVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        content = gsno(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

//MARK: TableView Delegate and DataSource
extension EvaluationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else if section == 1{
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return displayEvaluationPointSectionCell()
        case 1:
            return displayEvaluationElementListSectionCell(indexPath)
        case 2:
            return displayDescriptionSectionCell()
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func displayEvaluationPointSectionCell() -> UITableViewCell {
        let cell = evaluationTableView.dequeueReusableCell(withIdentifier: "TotalEvaluationTVCell") as! TotalEvaluationTVCell
        cell.percentLabel.text = "\(evaluationPoint)"
        if rateViewIndex != nil{
            for i in 0...gino(rateViewIndex) {
                cell.ratingView.ratingViewArray[i].backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
            }
        }
        return cell
    }
    
    fileprivate func displayEvaluationElementListSectionCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = evaluationTableView.dequeueReusableCell(withIdentifier: "EvaluationListTVCell") as! EvaluationListTVCell
        let index = indexPath.row
        cell.titleLabel.text = evaluationTitleArray[index]
        cell.subjectLabel.text = evaluationSubjectArray[index]
        cell.colorFromVC = colorArray[index]
        cell.plusButton.addTarget(self, action: #selector(detectingButtonInCell(_:)), for: .touchUpInside)
        cell.minusButton.addTarget(self, action: #selector(detectingButtonInCell(_:)), for: .touchUpInside)
        return cell
    }
    
    fileprivate func displayDescriptionSectionCell() -> UITableViewCell {
        let cell = evaluationTableView.dequeueReusableCell(withIdentifier: "DescriptionTVCell") as! DescriptionTVCell
        cell.delegate = self as ExpandingCellDelegate
        cell.descriptionTextView.delegate = self
        return cell
    }
}

//MARK: Expand Description Cell Delegate
extension EvaluationVC: ExpandingCellDelegate {
    
    func updated(height: CGFloat) {
        UIView.setAnimationsEnabled(false)
        evaluationTableView.beginUpdates()
        evaluationTableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        let indexPath = IndexPath(row: 0, section: 2)
        evaluationTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
}
