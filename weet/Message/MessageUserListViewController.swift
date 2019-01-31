//
//  MessageUserListViewController.swift
//  weet
//
//  Created by owner on 2019/01/25.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MessageUserListViewController: ButtonBarPagerTabStripViewController {
    
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
