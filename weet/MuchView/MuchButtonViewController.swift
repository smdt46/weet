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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            // identifierが取れなかったら処理やめる
            return
        }
        
        if (identifier == "choice") {
            let selectVC = children[0] as! MuchViewController
            let muchCace: Int = selectVC.currentIndex
            let vc = segue.destination as! ChoiceViewController
            vc.matching_format_id = muchCace+1
        }
    }
    
}
