//
//  MainVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 16/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet var lectureTableView: UITableView!
    
    var titleTapGestureRecognizer: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lectureTableView.delegate = self
        lectureTableView.dataSource = self
        lectureTableView.allowsSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(titleTapAction(_:)))
        self.navigationController?.navigationBar.addGestureRecognizer(titleTapGestureRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.removeGestureRecognizer(titleTapGestureRecognizer)
    }

}

extension MainVC {
    @objc func titleTapAction(_ theObject: AnyObject) {
        guard let typeListVC = self.storyboard?.instantiateViewController(withIdentifier: "TypeListVC") else {return}
        self.present(typeListVC, animated: true, completion: nil)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = lectureTableView.dequeueReusableCell(withIdentifier: "PopularLectureTVCell", for: indexPath)
        cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
