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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 参照画面からJSONを受け取る
    var json: JSON = []
    
    // 選択されたイメージ格納用
    var selectedImg = UIImage()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api_url: String = "http://54.238.92.95:8080/api/v2/user/"+appDelegate.playerID
        Alamofire.request(api_url).responseJSON { response in
            guard let object = response.result.value else {
                self.Alert(title: "接続エラー", message: "ネットワーク・サーバーの状態を確認してください")
                return
            }
            
            self.json = JSON(object)
            let url: String = "http://54.238.92.95:8080/api/v1/answers"
            Alamofire.request(url).responseJSON { response in
                guard let object = response.result.value else {
                    print("接続エラー")
                    self.Alert(title: "接続エラー", message: "ネットワーク・サーバーの状態を確認してください")
                    return
                }
                
                let qjson = JSON(object)
                
                self.form
//                    +++ Section(header: "ユーザー画像", footer: "画像のアップロードは準備中です")
//                    <<< ImageRow {
//                        $0.title = "画像1"
//                        $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum, .Camera]
//                        $0.value = UIImage(named: "kmyan_icon")
//                        $0.clearAction = .yes(style: .destructive)
//                        $0.onChange { [unowned self] row in
//                            self.selectedImg = row.value!
//                            // パラメータにqidとaidを設定する
//                        }
//                    }
                    
                    +++ Section("ひとこと")
                    <<< TextRow { row in
                        row.tag = "hitokoto"
                        row.placeholder = "75文字以内"
                        row.value = self.json["user_basics"]["hitokoto"].stringValue
                        }.onChange{ row in
                            self.saveBasics()
                    }
                    
                    +++ Section("自己紹介")
                    <<< TextAreaRow { row in
                        row.tag = "comment"
                        row.placeholder = "300文字以内"
                        row.value = self.json["user_basics"]["comment"].stringValue
                    } .onChange { row in
                           self.saveBasics()
                    }
                
                // 友達・恋愛などフォーム作成
                for i in 0..<self.json["user_specials"].count {
                    
                    // セクションを作成
                    let section = Section(self.json["user_specials"][i]["matching_format_name"].stringValue)
                    // マッチング許可のスイッチ作成
//                    if (i != 0) {
//                        let switchRow = SwitchRow("switchRowTag\(String(i))"){
//                            $0.title = self.json["user_specials"][i]["matching_format_name"].stringValue + "マッチング許可"
//                            $0.value = UserDefaults.standard.bool(forKey: "isLoveChoice")
//
//                            // 許可情報をPOSTする.onChange使用予定
//
//                            } .onChange { row in
//                                self.saveChoice(updateChoice: i, updateSW: row.value!)
//                        }
//                        section.append(switchRow)
//                    }
                    
                    
                    // 行を作成
                    for j in 0..<self.json["user_specials"][i]["user_questions_and_answers"].count {
                        var dic: [String:Int] = [:]
                        
                        let row = PickerInputRow<String>() {
                            
                            // スイッチ関連
//                            if(i != 0){
//                                $0.hidden = Condition.function(["switchRowTag\(String(i))"], { form in
//                                    return !((form.rowBy(tag: "switchRowTag\(String(i))") as? SwitchRow)?.value ?? false)
//                                })
//                            }
                            
                            
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
                            $0.value = self.json["user_specials"][i]["user_questions_and_answers"][j]["answer_name"].stringValue
                            } .onChange { row in
                                let q_id: Int = self.json["user_specials"][i]["user_questions_and_answers"][j]["question_id"].intValue
                                let ans_id: Int = dic[row.value!]!
                                print("q_id: \(q_id)")
                                print("a_id: \(ans_id)")
                                self.saveProfile(q_id: q_id, a_id: ans_id)
                        }
                        section.append(row)
                    }
                    self.form.append(section)
                }
            }
        }
    }
    
    func Alert(title: String, message: String) {
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveChoice(updateChoice: Int, updateSW: Bool) {
//        switch updateChoice {
//        case 1:
//            UserDefaults.standard.set(updateSW, forKey: "isLoveChoice")
//        case 2:
//            UserDefaults.standard.set(updateSW,forKey: "isMarriageChoice")
//        case 3:
//            UserDefaults.standard.set(updateSW,forKey: "isRoommate")
//        default:
//            return
//        }
//        print(boolToInt(bool: UserDefaults.standard.bool(forKey: "isLoveChoice")))
//        print(boolToInt(bool: UserDefaults.standard.bool(forKey: "isMarriageChoice")))
//        print(boolToInt(bool: UserDefaults.standard.bool(forKey: "isRoommate")))
//        let parameters: Parameters = [
//            "Love": boolToInt(bool: UserDefaults.standard.bool(forKey: "isLoveChoice")),
//            "Marriage": boolToInt(bool: UserDefaults.standard.bool(forKey: "isMarriageChoice")),
//            "Roommate": boolToInt(bool: UserDefaults.standard.bool(forKey: "isRoommate"))
//        ]
//        let url: String = "http://localhost:8080/api/v1/matching-format-choices/"+appDelegate.playerID
//        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
//        print("basics_update_tap")
    }
    
    func saveBasics() {
        let hitokotoRow = form.rowBy(tag: "hitokoto") as! TextRow
        let hitokoto = hitokotoRow.value!
        let commentRow = form.rowBy(tag: "comment") as! TextAreaRow
        let comment = commentRow.value!
        
        let parameters: Parameters = [
            "UserName": json["user_basics"]["user_name"].stringValue,
            "Image1": json["user_basics"]["image1"].stringValue,
            "Image2": "",
            "Image3": "",
            "Age": json["user_basics"]["age"].intValue,
            "Sex": json["user_basics"]["sex"].stringValue,
            "Hitokoto": hitokoto,
            "Comment": comment
        ]
        let url: String = "http://54.238.92.95:8080/api/v1/user/\(appDelegate.playerID)/update/basics"
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
        print("basics_update_tap")
    }
    
    // 質問選択肢をPOSTして更新する
    func saveProfile(q_id: Int, a_id: Int) {
        let parameters: Parameters = [
            "question_id": q_id,
            "answer_id": a_id
        ]
        let url: String = "http://54.238.92.95:8080/api/v1/user/\(appDelegate.playerID)/update/specials"
        Alamofire.request(url, method: .put, parameters: parameters)
        print("profile_update")
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
    
    func boolToInt(bool: Bool) -> Int {
        if (bool) {
            return 1
        } else {
            return 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
