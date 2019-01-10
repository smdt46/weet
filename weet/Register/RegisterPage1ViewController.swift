//
//  RegisterPage1ViewController.swift
//  weet
//
//  Created by owner on 2019/01/07.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class RegisterPage1ViewController: UIViewController {
    
    //let URL_SAVE_BOY = "http://localhost/api/saveBoy.php"

    @IBOutlet weak var userMailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // パスワード欄は非表示
        userPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userMailAddress = userMailAddressTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        // 空白確認
        if(userMailAddress == "" || userPassword == "" || userRepeatPassword == "") {
            // アラートメッセージ
            //displayMyAlertMessage(userMessage: "全てのフォームに入力してください。")
            return
        }
        
        // パスワード一致確認
        if(userPassword != userRepeatPassword) {
            //displayMyAlertMessage(userMessage: "パスワードが一致していません。")
            return
        }

    
        UserDefaults.standard.set(userMailAddress, forKey: "userName")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        self.performSegue(withIdentifier: "register", sender: self)
        
        
//        // createdNSURL
//        let requestURL = NSURL(string: URL_SAVE_BOY)
//
//        let request = NSMutableURLRequest(url: requestURL! as URL)
//
//        request.httpMethod = "POST"
//
//        let userMailAddress = userMailAddressTextField.text
//
//        let postParameters = "name="+userMailAddress!+"&old=aiueo"
//
//        // ボディをリクエストするためのパラメータを追加する
//        request.httpBody = postParameters.data(using: String.Encoding.utf8)
//        
//        // 投稿要求を送信するタスクを作成する
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data,response,error in
//
//            do {
//                //NSDictionaryに変換する
//                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//
//                //jsonデータの解析
//                if let parseJSON = myJSON {
//
//                    //stringの生成
//                    var msg : String!
//                    //jsonからのレスポンスを取得
//                    msg = parseJSON["message"] as! String?
//
//                    //返ってきたものを表示
//                    print(msg)
//
//                    // errorならアラートをメッセージと共に出して、再入力させる
//
//                }
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
        
        // メールアドレス有無の問い合わせ
        // 返ってきたJSONにエラーが無ければ、次の画面へ
        
        if(userMailAddressTextField.text != "") {
            //self.performSegue(withIdentifier: "register", sender: self)
        } else {
            print("おいｗメールアドレス入力しろよｗ")
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
