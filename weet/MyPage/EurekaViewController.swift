//
//  EurekaViewController.swift
//  weet
//
//  Created by owner on 2019/01/13.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Alamofire
import SwiftyJSON

class EurekaViewController: FormViewController {

    let unset: String = "未設定"
    
    // 参照画面からJSONを受け取る
    var json: JSON = []
    
    // 選択されたイメージ格納用
    var selectedImg = UIImage()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        if appDelegate.myJson != nil {
            
            let url: String = "http://54.238.92.95:8080/api/v1/answers"
            Alamofire.request(url).responseJSON { response in
                guard let object = response.result.value else {
                    print("接続エラー")
                    self.errorAlert()
                    return
                }
                
                let qjson = JSON(object)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                self.json = appDelegate.myJson!
                
                self.form
                    +++ Section("ユーザー画像")
                    <<< ImageRow {
                        $0.title = "画像1"
                        $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum, .Camera]
                        $0.value = UIImage(named: "defaultIcon.png")
                        $0.clearAction = .yes(style: .destructive)
                        $0.onChange { [unowned self] row in
                            self.selectedImg = row.value!
                            // パラメータにqidとaidを設定する
                        }
                    }
                    
                    +++ Section("ひとこと")
                    <<< TextRow { row in
                        row.placeholder = "75文字以内"
                        row.value = self.json["user_basics"]["hitokoto"].stringValue
                        }.onChange { row in
                            if let value = row.value {
                                print(value)
                            }
                    }
                    
                    +++ Section("自己紹介")
                    <<< TextAreaRow { row in
                        row.placeholder = "300文字以内"
                        row.value = self.json["user_basics"]["comment"].stringValue
                        } .onChange { row in
                            if let value = row.value {
                                print(value)
                            }
                }
                
                // 友達・恋愛などフォーム作成
                for i in 0..<self.json["user_specials"].count {
                    // セクションを作成
                    let section = Section(self.json["user_specials"][i]["matching_format_name"].stringValue)
                    // 行を作成
                    for j in 0..<self.json["user_specials"][i]["user_questions_and_answers"].count {
      
                            let row = PickerInputRow<String>() {
                                // タイトル設定
                                $0.title = self.json["user_specials"][i]["user_questions_and_answers"][j]["question_name"].stringValue

                                // 一致するanswersを探索し、選択肢を設定
                                for k in 0..<qjson.count {
                                    if self.json["user_specials"][i]["user_questions_and_answers"][j]["question_id"] == qjson[k]["question_id"] {
                                        print(self.makeAnsArry(json: qjson[k]["candidate_answer"]))
                                        $0.options = self.makeAnsArry(json: qjson[k]["candidate_answer"])
                                        break
                                    }
                                }
                                
                                // デフォルト値設定
                                $0.value = self.json["user_specials"][i]["user_questions_and_answers"][j]["answer_name"].stringValue
                            }
                        section.append(row)
                    }
                    self.form.append(section)
                }
            }
            
            
        } else {
            print("接続エラー")
            errorAlert()
        }
    }
    

    @IBAction func saveButton(_ sender: Any) {
        // 表示の大元がViewControllerかNavigationControllerかで戻る場所を判断する
        if self.presentingViewController is UINavigationController {
            //  表示の大元がNavigationControllerの場合
            let nc = self.presentingViewController as! UINavigationController
            let vc = nc.topViewController as! MainViewController
            // vc.json = self.json
            vc.loadView()
            vc.viewDidLoad()
            self.dismiss(animated: true, completion: nil)
            
        } else {
            // 表示元がViewControllerの場合
            // 前画面のViewControllerを取得
            let count = (self.navigationController?.viewControllers.count)! - 2
            let vc = self.navigationController?.viewControllers[count] as! MainViewController
            // AlamofireでGETし、AppDelegateのJSONを更新する
            // vc.json = self.json
            // 画面更新
            vc.loadView()
            vc.viewDidLoad()
            // 画面を消す
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func errorAlert() {
        let title = "接続エラー"
        let message = "ネットワーク・サーバーの状態を確認してください"
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 質問選択肢をPOSTして更新する
    func saveProfile(q_id: Int, a_id: Int) {
        let parameters: Parameters = [
            "user_id": 1,
            "question_id": q_id,
            "answer_id": a_id
        ]
        let url: String = "http://54.238.92.95:8080/test"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    // 選択肢の配列を返す
    func makeAnsArry(json: JSON) -> Array<String> {
        var Arry: [String] = []
        for i in 0..<json.count {
            Arry.append(json[i]["answer_name"].stringValue)
        }
        return Arry
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
