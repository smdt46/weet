//
//  MuchEurekaViewController.swift
//  weet
//
//  Created by  koshi on 2019/01/24.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Eureka

class MuchEurekaViewController: FormViewController {
    
        var selectedGender : String = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
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
                    row.options = ["男性","女性"]
                    row.value = "女性"
                }
                
                <<< IntRow { row in
                    row.title = "年齢"
                    row.value = 18
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
                    row.value = "兵庫県"
                }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
  
