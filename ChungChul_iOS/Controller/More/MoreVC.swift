//
//  MoreVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift
import BigInt
import Lottie

class MoreVC: UIViewController, NetworkCallback {
    
    // UI IBOutlet Variable
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileEmailLabel: UILabel!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var myWalletView: UIView!
    @IBOutlet var walletKlayLabel: UILabel!
    @IBOutlet var walletAddressLabel: UILabel!
    @IBOutlet var privateKeyLabel: UILabel!
    @IBOutlet var walletAddressCopyButton: UIButton!
    @IBOutlet var privateKeyCopyButton: UIButton!
    @IBOutlet var paymentDetailTableView: UITableView!
    
    let animationView = LOTAnimationView(name: "loading")
    let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    // Caver Singleton Instance Variable
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    
    // Data Variable
    var myLectureListDataFromServer: [MyLectureVO]?
    
    // Variable
    let ud = UserDefaults.standard
    var userKlay = BigUInt(0)
    var privateKey: String?
    var key: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting(title: "더보기", isTranslucent: false)
        addTargetButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callPaymentDetailDataFromServer()
        checkToken()
    }
    
    func networkResult(resultData: Any, code: String) {
        if code == "Success To Get Farmer My Lecture"{
            myLectureListDataFromServer = resultData as? [MyLectureVO]
            tableViewSetting()
        }
    }
    
    func networkFailed() {
        simpleAlert(title: "네트워크 오류", msg: "인터넷 연결을 확인해주세요.")
    }
    
    // Get Klay Balances
    fileprivate func getKlayBalance() {
        let caver = instance.caver
        let userAddress = instance.userAddress
        let keystore = instance.keystoreMangaerInDevice()
        DispatchQueue.global(qos: .utility).async {
            do{
                self.userKlay = try caver.eth.getBalance(address: userAddress)
                self.key = try keystore?.UNSAFE_getPrivateKeyData(password: self.gsno(self.ud.string(forKey: "password")), account: userAddress)
            }catch{
                print("Get Klay Balance Fail")
            }
            DispatchQueue.main.async {
                // Private Key Extract
                self.privateKey = "0x" + self.gsno(self.key?.toHexString())
                self.walletKlayLabel.text = "\(self.userKlay.string(unitDecimals: 18))"
                self.walletAddressLabel.text = "\(userAddress)"
                self.finishDownloadingDataFromKlaytn()
            }
        }
    }
}

extension MoreVC {
    
    // Wallet Address Copy Button Action Selector
    @objc func walletAddressCopyButtonAction(){
        UIPasteboard.general.string = walletAddressLabel.text
        simpleAlert(title: "지갑 주소 복사", msg: gsno(UIPasteboard.general.string))
    }
    
    // PrivateKey Copy Button Action Selector
    @objc func privateKeyCopyButtonAction(){
        UIPasteboard.general.string = privateKey
        simpleAlert(title: "개인키 복사", msg: gsno(UIPasteboard.general.string))
    }
    
    // Logout Button Action Selector
    @objc func logoutButtonAction() {
        for key in ud.dictionaryRepresentation().keys {
            ud.removeObject(forKey: key)
        }
        let alertController = UIAlertController(title: "로그아웃", message: "로그아웃되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            let main = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = main.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func callPaymentDetailDataFromServer() {
        let token = gsno(ud.string(forKey: "token"))
        let model = MyLectureModel(self)
        model.callMyLectureList(token: token)
    }
    
    fileprivate func tableViewSetting() {
        paymentDetailTableView.delegate = self
        paymentDetailTableView.dataSource = self
        paymentDetailTableView.allowsSelection = false
        paymentDetailTableView.tableFooterView = UIView(frame: CGRect.zero)
        paymentDetailTableView.tableHeaderView = UIView(frame: CGRect.zero)
    }
    
    // Login Alert View Setting
    fileprivate func makeLoginAlertView() {
        let loginAlertView = LoginAlertView(frame: UIApplication.shared.keyWindow!.frame)
        UIApplication.shared.keyWindow!.addSubview(loginAlertView)
    }
    
    // Add Target Button
    fileprivate func addTargetButton() {
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        walletAddressCopyButton.addTarget(self, action: #selector(walletAddressCopyButtonAction), for: .touchUpInside)
        privateKeyCopyButton.addTarget(self, action: #selector(privateKeyCopyButtonAction), for: .touchUpInside)
    }
    
    // User Token Check Function
    fileprivate func checkToken() {
        if ud.string(forKey: "token") == nil {
            makeLoginAlertView()
        } else {
            indicatorViewSetting(indicatorView, animationView)
            viewSetting()
            walletKlayLabel.text = "0"
            dataSetting()
        }
    }
    
    fileprivate func buttonUISetting(_ button: UIButton, _ cgColor: CGColor) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
    }
    
    fileprivate func viewSetting() {
        myWalletView.layer.masksToBounds = true
        myWalletView.layer.cornerRadius = 6
        buttonUISetting(logoutButton, #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1))
        buttonUISetting(privateKeyCopyButton, #colorLiteral(red: 1, green: 0.6766031981, blue: 0, alpha: 1))
        buttonUISetting(walletAddressCopyButton, #colorLiteral(red: 1, green: 0.6766031981, blue: 0, alpha: 1))
    }
    
    fileprivate func dataSetting(){
        profileNameLabel.text = ud.string(forKey: "name")
        profileEmailLabel.text = ud.string(forKey: "mail")
        getKlayBalance()
    }
    
    fileprivate func finishDownloadingDataFromKlaytn(){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.animationView.stop()
            self.indicatorView.removeFromSuperview()
        }
    }
}

extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myLectureListDataFromServer == nil{
            return 0
        } else {
            return (myLectureListDataFromServer?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setPaymentDetailCell(indexPath)
    }
    
    fileprivate func setPaymentDetailCell(_ indexPath: IndexPath) -> UITableViewCell{
        let cell = paymentDetailTableView.dequeueReusableCell(withIdentifier: "PaymentDetailTVCell") as! PaymentDetailTVCell
        if myLectureListDataFromServer != nil{
            let index = myLectureListDataFromServer![indexPath.row]
            cell.lectureNumberButton.setTitle("\(gino(index.lecturePk))", for: .normal)
            cell.lectureTitleLabel.text = gsno(index.title)
            cell.lecturePaymentDateLabel.text = gsno(index.applyTime) + " 결제"
            cell.paidKlayLabel.text = "- " + "\(gino(index.price))" + "KLAY"
        }
        return cell
    }
}
