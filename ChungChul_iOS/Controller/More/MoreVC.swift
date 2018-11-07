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
    @IBOutlet var profileMyButton: UIButton!
    @IBOutlet var myWalletView: UIView!
    @IBOutlet var walletKlayLabel: UILabel!
    @IBOutlet var walletAddressLabel: UILabel!
    @IBOutlet var privateKeyLabel: UILabel!
    @IBOutlet var walletAddressCopyButton: UIButton!
    @IBOutlet var privateKeyCopyButton: UIButton!
    
    let instance: CaverSingleton = CaverSingleton.sharedInstance
    let ud = UserDefaults.standard
    var userKlay = BigUInt(0)
    let loginAlertView = LoginAlertView(frame: UIApplication.shared.keyWindow!.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        if ud.string(forKey: "token") == nil {
            UIApplication.shared.keyWindow!.addSubview(loginAlertView)
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
        UIApplication.shared.keyWindow!.willRemoveSubview(loginAlertView)
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
        } catch {
            print("Get Klay Balance Fail")
        }
    }
    
    func borderSetting() {
        myWalletView.layer.masksToBounds = true
        myWalletView.layer.cornerRadius = 6
        
        profileMyButton.layer.borderWidth = 1.0
        profileMyButton.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4666666667, blue: 0.8705882353, alpha: 1)
        profileMyButton.layer.masksToBounds = true
        profileMyButton.layer.cornerRadius = 15
        
        privateKeyCopyButton.layer.borderWidth = 1.0
        privateKeyCopyButton.layer.borderColor = #colorLiteral(red: 1, green: 0.6766031981, blue: 0, alpha: 1)
        privateKeyCopyButton.layer.masksToBounds = true
        privateKeyCopyButton.layer.cornerRadius = 15
        
        walletAddressCopyButton.layer.borderWidth = 1.0
        walletAddressCopyButton.layer.borderColor = #colorLiteral(red: 1, green: 0.6766031981, blue: 0, alpha: 1)
        walletAddressCopyButton.layer.masksToBounds = true
        walletAddressCopyButton.layer.cornerRadius = 15
    }
    
}

