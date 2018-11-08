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

class MoreVC: UIViewController {
    
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
    
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    let ud = UserDefaults.standard
    var userKlay = BigUInt(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)

        if ud.string(forKey: "token") == nil {
            makeLoginAlertView()
        } else {
            borderSetting()
            walletKlayLabel.text = "0"
            dataSetting()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    fileprivate func makeLoginAlertView() {
        let loginAlertView = LoginAlertView(frame: UIApplication.shared.keyWindow!.frame)
        UIApplication.shared.keyWindow!.addSubview(loginAlertView)
    }
    
    func navigationBarSetting(){
        self.title = "더보기"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Bold", size: 24)!]
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func dataSetting(){
        profileNameLabel.text = ud.string(forKey: "name")
        profileEmailLabel.text = ud.string(forKey: "mail")
        
        let caver = instance.caver
        let userAddress = instance.userAddress
        
        do {
            userKlay = try caver.eth.getBalance(address: userAddress)
            walletKlayLabel.text = "\(userKlay.string(unitDecimals: 18))"
            walletAddressLabel.text = "\(userAddress)"
        } catch {
            print("Get Klay Balance Fail")
        }
    }
    
    func borderSetting() {
        myWalletView.layer.masksToBounds = true
        myWalletView.layer.cornerRadius = 6
        
        logoutButton.layer.borderWidth = 1.0
        logoutButton.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 15
        
        privateKeyCopyButton.layer.borderWidth = 1.0
        privateKeyCopyButton.layer.borderColor = #colorLiteral(red: 1, green: 0.6766031981, blue: 0, alpha: 1)
        privateKeyCopyButton.layer.masksToBounds = true
        privateKeyCopyButton.layer.cornerRadius = 15
        
        walletAddressCopyButton.layer.borderWidth = 1.0
        walletAddressCopyButton.layer.borderColor = #colorLiteral(red: 1, green: 0.6766031981, blue: 0, alpha: 1)
        walletAddressCopyButton.layer.masksToBounds = true
        walletAddressCopyButton.layer.cornerRadius = 15
    }
    
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
}

