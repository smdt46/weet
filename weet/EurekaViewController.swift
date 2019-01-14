//
//  EurekaViewController.swift
//  weet
//
//  Created by owner on 2019/01/13.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Eureka

class EurekaViewController: FormViewController {

    let unset: String = "未設定"
    let sectionTitle = "セクションタイトル"
    
    let sectionTitleArry: [String] = ["友達"]
    let rowTitleArry: [String] = ["職業"]
    let jobArry: [String] = ["未設定", "IT", "農業", "弁護士", "医者", "公務員"]
    
    let qArry: [(name: String, ans: [String], value: String)] = [
        ("職業",["未設定", "IT", "農業", "弁護士", "医者", "公務員"], "未設定"),
        ("学歴",["未設定", "高校卒", "短大/専門卒", "大学卒", "大学院卒", "その他"], "高校卒")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // フォーム作成
        for sectionRow in sectionTitleArry {
            // セクションを作成
            let section = Section(sectionRow)
            for i in 0..<qArry.count {
                // 条件分岐でフォームの形式を判定して行を作成する
                let row = PickerInputRow<String>() {
                    $0.title = qArry[i].name
                    $0.options = qArry[i].ans
                    $0.value = qArry[i].value
                }
                section.append(row)
            }
            form.append(section)
        }
        
        
        
        
        
        
//        form
//            +++ Section() {
//                $0.header = {
//                    let header = HeaderFooterView<UIView>(.callback({
//                        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
//                        let image1 = UIImage(named: "pose_furikaeru_man.png") // (1)
//                        let imageView = UIImageView(image:image1)   // (2)
//                        view.addSubview(imageView)  // (3)
//                        return view
//                    }))
//                    return header
//                }()
//            }
//
//
//
//        +++ Section("基本情報")
//            <<< TextRow { row in
//                row.title = "ニックネーム"
//            }
//
//        +++ Section("自己紹介")
//            <<< TextAreaRow { row in
//        }
//
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
