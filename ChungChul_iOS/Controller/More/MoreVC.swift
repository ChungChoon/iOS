//
//  MoreVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift

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
    
    var bip32keystore:BIP32Keystore?
    var keystoremanager:KeystoreManager?
    var contract:web3.web3contract?
    var web3Klaytn:web3?
    var userAddress: String?
    var ethAdd: EthereumAddress?
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = userDir+"/keystore/"
        keystoremanager =  KeystoreManager.managerForPath(path, scanForHDwallets: true, suffix: "json")
        self.web3Klaytn?.addKeystoreManager(self.keystoremanager)
        self.bip32keystore = self.keystoremanager?.bip32keystores[0]
        userAddress = self.bip32keystore?.addresses?.first?.address
        borderSetting()
        walletKlayLabel.text = "0"


        dataSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let web3 = Web3.new(URL(string: "http://localhost:8551")!)
        let ethAdd = EthereumAddress(gsno(userAddress))
        let balancebigint = web3?.eth.getBalance(address: ethAdd!).value
        walletKlayLabel.text = gsno(Web3.Utils.formatToEthereumUnits(balancebigint ?? 0)!)
        
    }
    
    func dataSetting(){
        profileNameLabel.text = ud.string(forKey: "name")
        profileEmailLabel.text = ud.string(forKey: "mail")
        walletAddressLabel.text = userAddress
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

