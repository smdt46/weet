//
//  RegisterPageViewController.swift
//  weet
//
//  Created by owner on 2019/01/06.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    var userMailAddress: String = ""
    @IBOutlet weak var userMailAddressLabel: UILabel!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userSexTextField: SexPickerKeyboard!
    @IBOutlet weak var userBirthdayTextField: DatePickerKeyboard!
    @IBOutlet weak var userPrefecturesTextField: PrefecturesPickerKeyboard!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // パスワード欄は非表示
        userPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
        userMailAddressLabel.text = userMailAddress
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // 次へボタン押下
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        let userName = userNameTextField.text
        let userSex = userSexTextField.text!
        let userBirthday = userBirthdayTextField.text!
        let userPrefecture = userPrefecturesTextField.text!
        
        // 空白確認
        if(userMailAddress == "" || userPassword == "" || userRepeatPassword == "" || userName == "" || userSex == "" || userBirthday == "" || userPrefecture == "") {
            // アラートメッセージ
            displayMyAlertMessage(userMessage: "全てのフォームに入力してください。")
            return
        }
        
        // パスワード一致確認
        if(userPassword != userRepeatPassword) {
            displayMyAlertMessage(userMessage: "パスワードが一致していません。")
            return
        }
        
        // データ登録
        UserDefaults.standard.set(userMailAddress, forKey: "userName")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        //UserDefaults.standard.synchronize()
        
        // ログイン
        //UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        
        // メッセージアラートなど
        let myAlert = UIAlertController(title: "登録完了", message: "おめでとうございます！登録できました", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            // 次の画面へ
            action in self.performSegue(withIdentifier: "registerView3", sender: self)
        }
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true,completion: nil)
    }
    
    @IBAction func skipButton(_ sender: Any) {
        self.performSegue(withIdentifier: "registerView3", sender: self)
    }
    
    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert,animated: true,completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func kakuninButton(_ sender: Any) {
        print(userBirthdayTextField.text!)
        print(userSexTextField.text!)
        print(userPrefecturesTextField.text!)

    }
}
