//
//  UserImagePreviewTableViewCell.swift
//  weet
//
//  Created by owner on 2019/01/10.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class UserImagePreviewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    var imageArry: [Data] = []
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageAndAddressLabel: UILabel!
    
    // セル表示時の処理
    func cellViewData(image1Name: String, image2Name: String, image3Name: String, name: String, ageAndAddress: String) {
        
        // ニックネームをラベルに設定
        self.nameLabel.text = name
        // 年齢・居住地をラベルに設定
        self.ageAndAddressLabel.text = ageAndAddress
        
        // 画像一覧の角を丸くする
        self.image1.layer.cornerRadius = image1.frame.size.width * 0.5
        self.image2.layer.cornerRadius = image2.frame.size.width * 0.5
        self.image3.layer.cornerRadius = image3.frame.size.width * 0.5
        self.image1.layer.masksToBounds = true
        self.image2.layer.masksToBounds = true
        self.image3.layer.masksToBounds = true
        if (image1Name != "") {
            // 各画像を設定
            let imageURL1 = URL(string: image1Name)
//            let imageURL2 = URL(string: image2Name)
//            let imageURL3 = URL(string: image3Name)
            do {
                let data1 = try Data(contentsOf: imageURL1!)
                self.imageArry.append(data1)
                self.imageArry[0] = data1
//                let data2 = try Data(contentsOf: imageURL2!)
//                self.imageArry.append(data2)
//                self.imageArry[1] = data2
//                let data3 = try Data(contentsOf: imageURL3!)
//                self.imageArry.append(data3)
//                self.imageArry[2] = data3
                self.image1.setImage(UIImage(data: data1), for: .normal)
                self.image1.imageView?.contentMode = .scaleAspectFit
//                self.image2.setImage(UIImage(data: data2), for: .normal)
//                self.image2.imageView?.contentMode = .scaleAspectFit
//                self.image3.setImage(UIImage(data: data3), for: .normal)
//                self.image3.imageView?.contentMode = .scaleAspectFit
                // 1番目の画像をプレビュー部分に設定
                self.imagePreview.image = UIImage(data: data1)
            }catch let err {
                print("Error : \(err.localizedDescription)")
            }
        }
        

        
        // 1番目の画像に枠線を設定
        self.image1.layer.borderColor = UIColor.blue.cgColor
        self.image1.layer.borderWidth = 2
    }
    
    @IBAction func image1Button(_ sender: Any) {
        // 枠線を消す
        borderLineClear()
        
        // 枠線を設定
        self.image1.layer.borderColor = UIColor.blue.cgColor
        self.image1.layer.borderWidth = 2
        self.imagePreview.image = UIImage(data: self.imageArry[0])
    }
    
    @IBAction func image2Button(_ sender: Any) {
        // 枠線を消す
        borderLineClear()
        
        // 枠線を設定
        self.image2.layer.borderColor = UIColor.blue.cgColor
        self.image2.layer.borderWidth = 2
        self.imagePreview.image = UIImage(data: self.imageArry[1])
    }
    
    @IBAction func image3Button(_ sender: Any) {
        // 枠線を消す
        borderLineClear()
        
        // 枠線を設定
        self.image3.layer.borderColor = UIColor.blue.cgColor
        self.image3.layer.borderWidth = 2
        self.imagePreview.image = UIImage(data: self.imageArry[2])
    }
    
    // 全ての外枠線を消す
    func borderLineClear() {
        self.image1.layer.borderWidth = 0
        self.image2.layer.borderWidth = 0
        self.image3.layer.borderWidth = 0
    }
}
