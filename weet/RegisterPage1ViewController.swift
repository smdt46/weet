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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
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
        
        // メールアドレスの空白・書式確認
        // メールアドレス有無の問い合わせ
        // 返ってきたJSONにエラーが無ければ、次の画面へ
        
        if(userMailAddressTextField.text != "") {
            self.performSegue(withIdentifier: "registerView2", sender: self)
        } else {
            print("おいｗメールアドレス入力しろよｗ")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 次の画面を取り出す
        let viewController = segue.destination as! RegisterPageViewController
        
        viewController.userMailAddress = userMailAddressTextField.text!
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
