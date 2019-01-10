//
//  RegisterPageViewController.swift
//  weet
//
//  Created by owner on 2019/01/06.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userSexTextField: SexPickerKeyboard!
    @IBOutlet weak var userBirthdayTextField: DatePickerKeyboard!
    @IBOutlet weak var userPrefecturesTextField: PrefecturesPickerKeyboard!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // 次へボタン押下
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text
        let userSex = userSexTextField.text!
        let userBirthday = userBirthdayTextField.text!
        let userPrefecture = userPrefecturesTextField.text!
        
        // 空白確認
        if(userName == "" || userSex == "" || userBirthday == "" || userPrefecture == "") {
            // アラートメッセージ
            displayMyAlertMessage(userMessage: "全てのフォームに入力してください。")
            return
        }
        
        // メッセージアラートなど
        let myAlert = UIAlertController(title: "登録完了", message: "おめでとうございます！登録できました", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            // 次の画面へ
            action in self.performSegue(withIdentifier: "registerView3", sender: self)
        }
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true,completion: nil)
    }
    
    
    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert,animated: true,completion: nil)
    }
    
}
