//
//  TabBarVC.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = self.tabBar
        let lectureListImage = UIImage(named:"ic_lecture_blue")?.withRenderingMode(.alwaysOriginal)
        let myLectureImage = UIImage(named: "ic_mylist_blue")?.withRenderingMode(.alwaysOriginal)
        let moreImage = UIImage(named: "ic_more_blue")?.withRenderingMode(.alwaysOriginal)
        
        (tabBar.items![0] ).selectedImage = lectureListImage
        (tabBar.items![1] ).selectedImage = myLectureImage
        (tabBar.items![2] ).selectedImage = moreImage
    }

}
