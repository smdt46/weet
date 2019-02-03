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
        let eurekaVC = children[1] as! MuchEurekaViewController
        
        let sex: String = eurekaVC.sex
        let age: Int = eurekaVC.age
        let pref: String = eurekaVC.pref
        
        // PUTする（後日実装）
        
        // デバッグ用
        print(sex)
        print(age)
        print(pref)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            // identifierが取れなかったら処理やめる
            return
        }
        
        if (identifier == "choice") {
            let selectVC = children[0] as! MuchViewController
            let muchCace: Int = selectVC.currentIndex
            let vc = segue.destination as! ChoiceViewController
            vc.matching_format_id = String(muchCace+1)
        }
    }
    
}
