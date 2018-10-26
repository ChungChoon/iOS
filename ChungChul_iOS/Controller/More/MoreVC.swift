//
//  MoreVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

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
    @IBOutlet var transactionTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        transactionTableView.delegate = self
        transactionTableView.dataSource = self
    }
    
}

extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "TranscationTVCell", for: indexPath) as! TranscationTVCell
        
        return cell
    }
    
    
    
}

class TranscationTVCell: UITableViewCell {
    
    @IBOutlet var transactionImageView: UIImageView!
    @IBOutlet var lectureTitleLabel: UILabel!
    @IBOutlet var purchaseDayLabel: UILabel!
    @IBOutlet var costKlayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
