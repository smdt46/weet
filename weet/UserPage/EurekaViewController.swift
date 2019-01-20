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
    let sectionTitle: String = "セクションタイトル"
    
    let sectionTitleArry: [String] = ["友達"]
    let rowTitleArry: [String] = ["職業"]
    let jobArry: [String] = ["未設定", "IT", "農業", "弁護士", "医者", "公務員"]
    let bloodArry: [String] = ["未設定", "A型", "B型", "O型", "AB型", "不明"]
    
    let qArry: [(name: String, ans: [String], value: String)] = [
        ("職業",["未設定", "IT", "農業", "弁護士", "医者", "公務員"], "未設定"),
        ("学歴",["未設定", "高校卒", "短大/専門卒", "大学卒", "大学院卒", "その他"], "高校卒")
        
    ]
    
    var postPara: Parameters = [:]

    // 参照画面からJSONを受け取る
    var json: JSON = []
    
    // 選択されたイメージ格納用
    var selectedImg = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.json = appDelegate.myJson!
        
        form
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
                }.onChange { row in
                    if let value = row.value {
                        print(value)
                    }
            }
            
            +++ Section("自己紹介")
            <<< TextAreaRow { row in
                row.placeholder = "300文字以内"
                } .onChange { row in
                    if let value = row.value {
                        print(value)
                    }
            }
        
        // 友達・恋愛などフォーム作成
        for i in 0..<json["user_specials"].count {
            // セクションを作成
            let section = Section(json["user_specials"][i]["matching_format_name"].stringValue)
            // 行を作成
            for j in 0..<json["user_specials"][i]["user_questions_and_answers"].count {
                if (i == 0 && j == 0) {
                    let row = PickerInputRow<String>() {
                        $0.title = json["user_specials"][i]["user_questions_and_answers"][j]["question_name"].stringValue
                        $0.options = self.bloodArry
                        $0.value = self.unset
                    }
                    section.append(row)
                } else {
                    let row = TextRow { row in
                        row.title = json["user_specials"][i]["user_questions_and_answers"][j]["question_name"].stringValue
                    }
                    section.append(row)
                }
                // 条件分岐でフォームの形式を判定して行を作成する
//                let row = PickerInputRow<String>() {
//                    $0.title = qArry[i].name
//                    $0.options = qArry[i].ans
//                    $0.value = qArry[i].value
//                }
                
            }
            form.append(section)
        }
        

//        +++ Section("友達")
//        <<< PickerInputRow<String>() {
//            $0.title = "学歴"
//            $0.options = ["未設定", "高校卒", "短大/専門卒", "大学卒", "大学院卒", "その他"]
//            $0.value = self.unset
//        }
//            <<< PickerInputRow<String>() {
//                $0.title = "職業"
//                $0.options = ["未設定", "IT", "農業", "弁護士", "医者", "公務員"]
//                $0.value = self.unset
//        }
//            <<< PickerInputRow<String>() {
//                $0.title = "血液型"
//                $0.options = ["未設定","A型", "B型", "O型", "AB型", "不明"]
//                $0.value = self.unset
//        }
//
//        +++ Section("恋愛")
//            <<< PickerInputRow<String>() {
//                $0.title = "恋愛対象(性別)"
//                $0.options = ["未設定", "男性", "女性", "両方"]
//                $0.value  = self.unset
//            }
//            <<< PickerInputRow<String>() {
//                $0.title = "恋愛対象(最小年齢)"
//                $0.options = ["未設定", "18", "19", "20", "21", "22", "23"]
//                $0.value = self.unset
//            }
//            <<< PickerInputRow<String>() {
//                $0.title = "恋愛対象(最大年齢)"
//                $0.options = ["未設定", "18", "19", "20", "21", "22", "23"]
//                $0.value = self.unset
//            }
//
//        +++ Section("婚活")
//            <<< PickerInputRow<String>() {
//                $0.title = "年収"
//                $0.options = ["300万未満", "300万〜500万", "500万〜700万", "700万以上"]
//                $0.value = self.unset
//            }
//        +++ Section("ルームメイト")
//            <<< MultipleSelectorRow<String>() {
//                $0.title = "目的は？"
//                $0.options = ["未設定", "人脈を広げたい", "趣味を満喫できる暮らしがしたい", "夢や志が同じ人たちと切磋琢磨しながら生活したい", "その他"]
//                $0.value = [self.unset]
//        }
    }
    @IBAction func saveButton(_ sender: Any) {
        // パラメータ配列を使い、
        // AlamofireでAPIにPOSTする
//        let data = UIImage(named: "defaultIcon.png")?.jpegData(compressionQuality: 1.0)
//
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append(data!, withName: "file", fileName: "test.jpeg", mimeType: "image/jpeg")
//        },
//            to: "http://localhost/normal_post1.php",
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        debugPrint(response)
//                        guard let object = response.result.value else {
//                            return
//                        }
//                        print(JSON(object))
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//        }
//        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
