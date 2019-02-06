//
//  ViewController.swift
//  weet
//
//  Created by owner on 2019/01/06.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.set(nil, forKey: "playerID")
        
        // タイトル画面へ
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "title")
        present(nextView, animated: true, completion: nil)
    }
}

