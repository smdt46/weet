//
//  LoginViewController.swift
//  weet
//
//  Created by owner on 2019/01/06.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userPasswordTextField.isSecureTextEntry = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text
        if(userName == "1" || userName == "2" || userName == "3" || userName == "4" || userName == "5" || userName == "6" || userName == "7" || userName == "8" || userName == "9") {
        
            // ユーザ基本情報が登録されていなかったら
            // 基本情報入力画面に遷移する
            // 入力されていたら、UserDefaultsにユーザIDとログイン状態を保存し、メイン画面に遷移する
            
            // ログイン
            let url: String = "http://54.238.92.95:8080/api/v2/user/"+userName!
            Alamofire.request(url).responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.myJson = JSON(object)
                appDelegate.playerID = userName!
                UserDefaults.standard.set(userName, forKey: "playerID")
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                //UserDefaults.standard.synchronize()
                //self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "tabMain", sender: self)
                print("AppDelegate Request")
            }
        } else {
            print("ユーザーネームが違う")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
