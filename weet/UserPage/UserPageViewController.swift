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
    
    
    override func viewDidLoad() {
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor.white
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.darkGray
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
        
        // 選別画面から画面遷移時に渡されたUserIDを変数で
        // ユーザー情報の取得
        let url: String = "http://54.238.92.95:8080/api/v1/user/2"
        Alamofire.request(url).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            
            self.json = JSON(object)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.userJson! = self.json
            
            print("UserPage Request")
        }
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfiel")
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userIdeal")
        let childViewControllers:[UIViewController] = [firstVC, secondVC]
        return childViewControllers
    }
}
