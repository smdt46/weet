//
//  TitleViewController.swift
//  weet
//
//  Created by owner on 2019/01/06.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func demoLogin(_ sender: Any) {
        // ログイン
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        //UserDefaults.standard.synchronize()
        //self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "demo", sender: self)
    }
    
}
