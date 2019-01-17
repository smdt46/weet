//
//  MainViewController.swift
//  weet
//
//  Created by owner on 2019/01/17.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {
    
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
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Mypage")
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Ideal")
        let childViewControllers:[UIViewController] = [firstVC, secondVC]
        return childViewControllers
    }
}
