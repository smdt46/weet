//
//  MuchEurekaViewController.swift
//  weet
//
//  Created by  koshi on 2019/01/24.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Eureka
import Alamofire

class MuchEurekaViewController: FormViewController {
    
        var selectedGender : String = ""
    var sex: String = "女性"
    var age: Int = 18
    var pref: String = "兵庫県"
    let ageArray:[Int] = ([Int])(18...60)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            form
                +++ Section("条件")
//                <<< PickerRow<String>() { row in
//                    row.title = "曜日"
//                    row.options = ["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"]
//                    row.value = row.options.first
//                    }.onChange {[unowned self] row in
//                        self.selectedGender = row.value!
//                        print(self.selectedGender )
//                }
                <<< SegmentedRow<String>() { row in
                    row.title = "性別"
                    row.options = ["男性","女性","両方"]
                    row.value = self.sex
                } .onChange { row in
                        self.sex = row.value!
                        var SexID:Int = 2
                        switch self.sex {
                        case "男性":
                            SexID = 1
                        case "女性":
                            SexID = 2
                        case "両方":
                            SexID = 3
                        default:
                            SexID = 2
                        }
                    
                        // PUTする
                        let parameters: Parameters = [
                            "SexID": SexID
                        ]
                        print("SexID: \(SexID)")
                        let api_url:String = "http://54.238.92.95:8080/api/v1/matching-sexes/"+appDelegate.playerID
                        Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                }
                
                <<< PickerInputRow<Int>() { row in
                    row.title = "年齢"
                    row.options = self.ageArray
                    row.value = self.age
                } .onChange { row in
                    self.age = row.value!
                    let parameters: Parameters = [
                        "FirstAge": self.age-3,
                        "LastAge": self.age+3
                    ]
                    print("Age: \(self.age)")
                    let api_url:String = "http://54.238.92.95:8080/api/v1/matching-ages/"+appDelegate.playerID
                    Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                }

                <<< PickerInputRow<String>() { row in
                    row.title = "居住地"
                    row.options = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                                   "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                                   "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                                   "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                                   "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                                   "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                                   "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
                    row.value = self.pref
                } .onChange { row in
                        self.pref = row.value!
                }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
  
