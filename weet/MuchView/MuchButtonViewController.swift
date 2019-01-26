//
//  MuchButtonViewController.swift
//  weet
//
//  Created by owner on 2019/01/27.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class MuchButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func MuchButton(_ sender: Any) {
        let selectVC = children[0] as! MuchViewController
        let eurekaVC = children[1] as! MuchEurekaViewController
        
        let muchCace: Int = selectVC.currentIndex
        let sex: String = eurekaVC.sex
        let age: Int = eurekaVC.age
        let pref: String = eurekaVC.pref
        
        // それぞれのパラメータを設定し、相手一覧をGETする
        // ↑後日実装
        
        // デバッグ用
        print(muchCace)
        print(sex)
        print(age)
        print(pref)
    }
    
}
