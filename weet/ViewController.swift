//
//  ViewController.swift
//  weet
//
//  Created by owner on 2019/01/06.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func postButton(_ sender: Any) {
        let parameters: Parameters = [
            "test": "kazumori!"
        ]
        let url: String = "http://54.238.92.95:8080/test"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
}

