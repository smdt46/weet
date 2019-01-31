//
//  goodListViewController.swift
//  weet
//
//  Created by owner on 2019/01/27.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class goodListViewController: ButtonBarPagerTabStripViewController {
    
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
        let fgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "friendGood")
        let lgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loveGood")
        let mgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "marriageGood")
        let rgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "roommateGood")
        let childViewControllers:[UIViewController] = [fgVC,lgVC,mgVC,rgVC]
        return childViewControllers
    }
}
