//
//  MyTabBarController.swift
//  weet
//
//  Created by owner on 2019/01/15.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // アイコンの色
        UITabBar.appearance().tintColor = UIColor(red: 240/255, green: 145/255, blue: 153/255, alpha: 1.0) // yellow
    }

}
