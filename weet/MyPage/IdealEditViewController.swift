//
//  IdealEditViewController.swift
//  weet
//
//  Created by owner on 2019/01/28.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import SwiftyJSON

class IdealEditViewController: FormViewController {

    var json: JSON = []
    // 選択されたイメージ格納用
    var selectedImg = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let api_url: String = "http://54.238.92.95:8080/api/v2/user/"+appDelegate.playerID
        Alamofire.request(api_url).responseJSON { response in
            guard let object = response.result.value else {
                self.errorAlert()
                return
            }
            
            self.json = JSON(object)
            let url: String = "http://54.238.92.95:8080/api/v1/answers"
            
            Alamofire.request(url).responseJSON { response in
                guard let object = response.result.value else {
                    self.errorAlert()
                    return
                }
                
                let qjson = JSON(object)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                // 友達・恋愛などフォーム作成
                for i in 0..<self.json["user_specials"].count {
                    // セクションを作成
                    let section = Section(self.json["user_specials"][i]["matching_format_name"].stringValue)
                    // 行を作成
                    for j in 0..<self.json["user_specials"][i]["user_questions_and_answers"].count {
                        var dic: [String:Int] = [:]
                        let row = MultipleSelectorRow<String>() {
                            // タイトル設定
                            
                            $0.title = self.json["user_specials"][i]["user_questions_and_answers"][j]["question_name"].stringValue
                            
                            // 一致するanswersを探索し、選択肢を設定
                            for k in 0..<qjson.count {
                                if self.json["user_specials"][i]["user_questions_and_answers"][j]["question_id"] == qjson[k]["question_id"] {
                                    dic = self.makeDicArry(json: qjson[k]["candidate_answer"])
                                    print(self.makeAnsArry(json: qjson[k]["candidate_answer"]))
                                    $0.options = self.makeAnsArry(json: qjson[k]["candidate_answer"])
                                    break
                                }
                            }
                            
                            // デフォルト値設定
                            var answers:[String] = []
                            for n in 0..<self.json["user_ideal_specials"][i]["user_ideal_questions_and_answers"][j]["ideal_answer_name"].count {
                                answers.append(self.json["user_ideal_specials"][i]["user_ideal_questions_and_answers"][j]["ideal_answer_name"][n].stringValue)
                            }
                            $0.value = Set<String>(answers)
                            
                            } .onChange { row in
                                let q_id: Int = self.json["user_specials"][i]["user_questions_and_answers"][j]["question_id"].intValue
                                //let ans_id: Int = dic[row.value!]!
                                let valueArray = Array(row.value!)
                                var ansArray:[Int] = []
                                var ansStr:String = ""
                                for i in 0..<valueArray.count {
                                    for (key,value) in dic {
                                        if (valueArray[i] == key) {
                                            ansArray.append(value)
                                            break
                                        }
                                    }
                                }
                                ansArray.sort { $0 < $1 }
                                for i in 0..<ansArray.count {
                                    ansStr = ansStr + String(ansArray[i])
                                    if i != ansArray.count - 1 {
                                        ansStr = ansStr + ","
                                    }
                                }
                                print("mfid: \(i+1)")
                                print("q_id: \(q_id)")
                                print("a_id: \(ansArray)")
                                print("ansStr: \(ansStr)")
                                let parameters: Parameters = [
                                    "matching_format_id": String(i+1),
                                    "question_id": q_id,
                                    "answer_ids": ansStr
                                ]
                                let api_url:String = "http://54.238.92.95:8080/api/v1/user/\(appDelegate.playerID)/update/ideal-specials"
                                Alamofire.request(api_url, method: .put, parameters: parameters)
                        }
                        section.append(row)
                    }
                    self.form.append(section)
                }
            }
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
            let count = (self.navigationController?.viewControllers.count)! - 3
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
    

    // 選択肢の配列を返す
    func makeAnsArry(json: JSON) -> Array<String> {
        var Arry: [String] = []
        for i in 0..<json.count {
            Arry.append(json[i]["answer_name"].stringValue)
        }
        return Arry
    }
    
    func makeDicArry(json: JSON) -> Dictionary<String, Int> {
        var DicArry: Dictionary<String, Int> = [:]
        for i in 0..<json.count {
            DicArry[json[i]["answer_name"].stringValue] = json[i]["answer_id"].intValue
        }
        print(DicArry)
        return DicArry
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
