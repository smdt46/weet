//
//  goodListViewController.swift
//  weet
//
//  Created by owner on 2019/01/27.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class goodListViewController: ButtonBarPagerTabStripViewController {
    
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
        let api_url = "http://54.238.92.95:8080/api/v1/favo/user/"+appDelegate.playerID
        Alamofire.request(api_url).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            self.appDelegate.favoJson = JSON(object)
            // 前画面のViewControllerを取得
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let friendVC = storyboard.instantiateViewController(withIdentifier: "friendGood") as! goodFriendListViewController
            let loveVC = storyboard.instantiateViewController(withIdentifier: "loveGood") as! goodLoveListViewController
            let marriageVC = storyboard.instantiateViewController(withIdentifier: "marriageGood") as! goodMarriageListViewController
            let roommateVC = storyboard.instantiateViewController(withIdentifier: "roommateGood") as! goodRoommateListViewController
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
        let fgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "friendGood")
        let lgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loveGood")
        let mgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "marriageGood")
        let rgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "roommateGood")
        let childViewControllers:[UIViewController] = [fgVC,lgVC,mgVC,rgVC]
        return childViewControllers
    }
}
