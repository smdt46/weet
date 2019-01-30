//
//  UserPageViewController.swift
//  weet
//
//  Created by owner on 2019/01/22.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class UserPageViewController: ButtonBarPagerTabStripViewController {
    
    var json: JSON = []
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var ageAndAddressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    var imageData1: Data?
    var imageData2: Data?
    var imageData3: Data?
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var sexLabel: UILabel!
    
    
    override func viewDidLoad() {
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor.white
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.darkGray
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.userJson != nil {
            self.json = appDelegate.userJson!

            // 画像を丸くする
            self.image1.layer.cornerRadius = self.image1.frame.size.width * 0.5
            self.image2.layer.cornerRadius = self.image2.frame.size.width * 0.5
            self.image3.layer.cornerRadius = self.image3.frame.size.width * 0.5
            self.image1.layer.masksToBounds = true
            self.image2.layer.masksToBounds = true
            self.image3.layer.masksToBounds = true
            
            if (self.json["user_basics"]["image1"].stringValue != "") {
                // 各画像を設定
                let imageURL = URL(string: self.json["user_basics"]["image1"].stringValue)
                do {
                    self.imageData1 = try Data(contentsOf: imageURL!)
                    self.image1.setImage(UIImage(data: self.imageData1!), for: .normal)
                    self.image1.imageView?.contentMode = .scaleAspectFit
                    // 1番目の画像をプレビュー部分に設定
                    self.imagePreview.image = UIImage(data: self.imageData1!)
                    print("image1Set")
                }catch let err {
                    print("Error : \(err.localizedDescription)")
                }
            }
            
            
            self.image1.layer.borderColor = UIColor.blue.cgColor
            self.image1.layer.borderWidth = 2
            
            // 名前セット
            self.nameLabel.text = self.json["user_basics"]["user_name"].stringValue
            // 年齢・居住地セット
            self.ageAndAddressLabel.text = self.json["user_basics"]["age"].stringValue + "歳"
            // 性別セット
            self.sexLabel.text = self.json["user_basics"]["sex"].stringValue
            switch self.json["user_basics"]["sex"].stringValue {
            case "男性":
                self.sexLabel.textColor = UIColor.blue
            case "女性":
                self.sexLabel.textColor = UIColor.red
            default:
                self.sexLabel.textColor = UIColor.black
            }
            
            // タイトルセット
            self.navigationItem.title = self.json["user_basics"]["user_name"].stringValue
            
            print("UserPage Request")
        } else {
            errorAlert()
        }
        
        print("MainLoad")
        
        super.viewDidLoad()
        
        self.goodButton.layer.cornerRadius = self.goodButton.frame.size.width * 0.5
        self.skipButton.layer.cornerRadius = self.skipButton.frame.size.width * 0.5
        self.goodButton.layer.masksToBounds = true
        self.skipButton.layer.masksToBounds = true
        
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
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let firstVC = UIStoryboard(name: "UserPage", bundle: nil).instantiateViewController(withIdentifier: "userProfile")
        let secondVC = UIStoryboard(name: "UserPage", bundle: nil).instantiateViewController(withIdentifier: "userIdeal")
        let childViewControllers:[UIViewController] = [firstVC, secondVC]
        return childViewControllers
    }
}
