//
//  MainViewController.swift
//  weet
//
//  Created by owner on 2019/01/17.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {
    
    var json: JSON = []
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageAndAddressLabel: UILabel!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    var imageData1: Data?
    var imageData2: Data?
    var imageData3: Data?
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
        
        // json取得
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 画像セット
//        let url = URL(string: json["user_basics"]["image1"].stringValue)
//        do {
//            let data = try Data(contentsOf: url!)
//            self.imagePreview.image = UIImage(data: data)
//
//        }catch let err {
//            print("Error : \(err.localizedDescription)")
//        }
        
        if appDelegate.myJson != nil {
            self.json = appDelegate.myJson!
            
            self.image1.layer.cornerRadius = image1.frame.size.width * 0.5
            self.image2.layer.cornerRadius = image2.frame.size.width * 0.5
            self.image3.layer.cornerRadius = image3.frame.size.width * 0.5
            self.image1.layer.masksToBounds = true
            self.image2.layer.masksToBounds = true
            self.image3.layer.masksToBounds = true
            
            if (json["user_basics"]["image1"].stringValue != "") {
                // 各画像を設定
                let imageURL = URL(string: json["user_basics"]["image1"].stringValue)
                do {
                    self.imageData1 = try Data(contentsOf: imageURL!)
                    //                self.image1.setImage(UIImage(data: self.imageData1!), for: .normal)
                    //                self.image1.imageView?.contentMode = .scaleAspectFit
                    // 1番目の画像をプレビュー部分に設定
                    self.imagePreview.image = UIImage(data: self.imageData1!)
                    print("image1Set")
                }catch let err {
                    print("Error : \(err.localizedDescription)")
                }
            }
            
            self.image1.layer.borderColor = UIColor.blue.cgColor
            self.image1.layer.borderWidth = 2
            
            
            // 画像をタップすることを可能に
            self.imagePreview.isUserInteractionEnabled = true
            
            // 画像をタップされたときのアクションを追加
            self.imagePreview.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.tapped(sender:)))
            )
            
            
            // 名前セット
            self.nameLabel.text = json["user_basics"]["user_name"].stringValue
            // 性別セット
            self.sexLabel.text = json["user_basics"]["sex"].stringValue
            switch json["user_basics"]["sex"].stringValue {
            case "男性":
                self.sexLabel.textColor = UIColor.blue
            case "女性":
                self.sexLabel.textColor = UIColor.red
            default:
                self.sexLabel.textColor = UIColor.black
            }
            // 年齢・居住地セット
            self.ageAndAddressLabel.text = json["user_basics"]["age"].stringValue + "歳"
            
            print("MainLoad")
        } else {
            print("接続エラー")
            errorAlert()
        }
        
        
        
        super.viewDidLoad()
    }
    
    @IBAction func imageButton1(_ sender: Any) {
    }
    @IBAction func imageButton2(_ sender: Any) {
    }
    @IBAction func imageButton3(_ sender: Any) {
    }
    
    
    @objc func tapped(sender: UITapGestureRecognizer){
        print("tapped")
        // Alamofireで云々
        self.performSegue(withIdentifier: "edit", sender: nil)
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
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Mypage")
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Ideal")
        let childViewControllers:[UIViewController] = [firstVC, secondVC]
        return childViewControllers
    }
}
