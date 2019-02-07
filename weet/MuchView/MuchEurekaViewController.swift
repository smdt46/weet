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
    var sex: String = UserDefaults.standard.string(forKey: "searchSex") ?? "女性"
    var SexID:Int = 2
    var age: Int = UserDefaults.standard.integer(forKey: "searchAge")
    var pref: [String] = UserDefaults.standard.stringArray(forKey: "searchPrefArry") ?? ["兵庫県"]
    let ageArray:[Int] = ([Int])(18...60)
    let prefDic:[String:Int] = ["北海道":1,"青森県":2,"岩手県":3,"宮城県":4,"秋田県":5,"山形県":6,"福島県":7,
                                "茨城県":8,"栃木県":9,"群馬県":10,"埼玉県":11,"千葉県":12,"東京都":13,"神奈川県":14,
                                "新潟県":15,"富山県":16,"石川県":17,"福井県":18,"山梨県":19,"長野県":20,"岐阜県":21,
                                "静岡県":22,"愛知県":23,"三重県":24,"滋賀県":25,"京都府":26,"大阪府":27,"兵庫県":28,
                                "奈良県":29,"和歌山県":30,"鳥取県":31,"島根県":32,"岡山県":33,"広島県":34,"山口県":35,
                                "徳島県":36,"香川県":37,"愛媛県":38,"高知県":39,"福岡県":40,"佐賀県":41,"長崎県":42,
                                "熊本県":43,"大分県":44,"宮崎県":45,"鹿児島県":46,"沖縄県":47]
        
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
                    switch row.value {
                    case "男性":
                        SexID = 1
                    case "女性":
                        SexID = 2
                    case "両方":
                        SexID = 3
                    default:
                        SexID = 2
                    }
                    let parameters: Parameters = [
                        "SexID": SexID
                    ]
                    let api_url:String = "http://54.238.92.95:8080/api/v1/matching-sexes/"+appDelegate.playerID
                    Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                    print("SexID: \(self.SexID)")
                    print("sexput")
                } .onChange { row in
                        UserDefaults.standard.set(row.value, forKey: "searchSex")
                        switch row.value {
                        case "男性":
                            self.SexID = 1
                        case "女性":
                            self.SexID = 2
                        case "両方":
                            self.SexID = 3
                        default:
                            self.SexID = 2
                        }
                    
                        // PUTする
                        let parameters: Parameters = [
                            "SexID": self.SexID
                        ]
                        let api_url:String = "http://54.238.92.95:8080/api/v1/matching-sexes/"+appDelegate.playerID
                        Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                    print("SexID: \(self.SexID)")
                    print("sexput")
                }
                
                <<< PickerInputRow<Int>() { row in
                    row.title = "年齢(±3で検索します)"
                    row.options = self.ageArray
                    row.value = self.age
                    let parameters: Parameters = [
                        "FirstAge": row.value!-3,
                        "LastAge": row.value!+3
                    ]
                    let api_url:String = "http://54.238.92.95:8080/api/v1/matching-ages/"+appDelegate.playerID
                    Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                    print("ageput")
                } .onChange { row in
                    UserDefaults.standard.set(row.value, forKey: "searchAge")
                    let parameters: Parameters = [
                        "FirstAge": row.value!-3,
                        "LastAge": row.value!+3
                    ]
                    print("Age: \(String(describing: row.value))")
                    let api_url:String = "http://54.238.92.95:8080/api/v1/matching-ages/"+appDelegate.playerID
                    Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                    print("ageput")
                }

                <<< MultipleSelectorRow<String>() { row in
                    row.title = "居住地"
                    row.options = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                                   "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                                   "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                                   "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                                   "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                                   "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                                   "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
                    row.value = Set<String>(self.pref)
                    let valueArray = Array(row.value!)
                    UserDefaults.standard.set(valueArray, forKey: "searchPrefArry")
                    var prefArray:[Int] = []
                    var prefStr:String = ""
                    for i in 0..<valueArray.count {
                        for (key,value) in self.prefDic {
                            if (valueArray[i] == key) {
                                prefArray.append(value)
                                break
                            }
                        }
                    }
                    prefArray.sort { $0 < $1 }
                    for i in 0..<prefArray.count {
                        prefStr = prefStr + String(prefArray[i])
                        if i != prefArray.count - 1 {
                            prefStr = prefStr + ","
                        }
                    }
                    let parameters: Parameters = [
                        "PrefecturesID": prefStr
                    ]
                    print("prefArray: \(prefArray)")
                    print(prefStr)
                    let api_url:String = "http://54.238.92.95:8080/api/v1/matching-prefectures/"+appDelegate.playerID
                    Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                } .onChange { row in
                    let valueArray = Array(row.value!)
                    UserDefaults.standard.set(valueArray, forKey: "searchPrefArry")
                    var prefArray:[Int] = []
                    var prefStr:String = ""
                    for i in 0..<valueArray.count {
                        for (key,value) in self.prefDic {
                            if (valueArray[i] == key) {
                                prefArray.append(value)
                                break
                            }
                        }
                    }
                    prefArray.sort { $0 < $1 }
                    for i in 0..<prefArray.count {
                        prefStr = prefStr + String(prefArray[i])
                        if i != prefArray.count - 1 {
                            prefStr = prefStr + ","
                        }
                    }
                    let parameters: Parameters = [
                        "PrefecturesID": prefStr
                    ]
                    print("prefArray: \(prefArray)")
                    print(prefStr)
                    let api_url:String = "http://54.238.92.95:8080/api/v1/matching-prefectures/"+appDelegate.playerID
                    Alamofire.request(api_url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
                }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
  
