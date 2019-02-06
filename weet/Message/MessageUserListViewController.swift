//
//  MessageUserListViewController.swift
//  weet
//
//  Created by owner on 2019/01/25.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class MessageUserListViewController: ButtonBarPagerTabStripViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor.white
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.darkGray
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
        super.viewDidLoad()
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        let api_url = "http://54.238.92.95:8080/api/v1/mutual-favo/user/"+appDelegate.playerID
        Alamofire.request(api_url).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            self.appDelegate.messageJson = JSON(object)
            // 前画面のViewControllerを取得
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let friendVC = storyboard.instantiateViewController(withIdentifier: "friendMessage") as! firendMessageUserListViewController
            let loveVC = storyboard.instantiateViewController(withIdentifier: "loveMessage") as! loveMessageUserListViewController
            let marriageVC = storyboard.instantiateViewController(withIdentifier: "marriageMessage") as! marriageMessageUserListViewController
            let roommateVC = storyboard.instantiateViewController(withIdentifier: "roommateMessage") as! roommateMessageUserListViewController
            self.loadView()
            self.viewDidLoad()
            friendVC.loadView()
            friendVC.viewDidLoad()
            loveVC.loadView()
            loveVC.viewDidLoad()
            marriageVC.loadView()
            marriageVC.viewDidLoad()
            roommateVC.loadView()
            roommateVC.viewDidLoad()
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let fmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "friendMessage")
        let lmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loveMessage")
        let mmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "marriageMessage")
        let rmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "roommateMessage")
        let childViewControllers:[UIViewController] = [fmVC, lmVC, mmVC, rmVC]
        return childViewControllers
    }
}
