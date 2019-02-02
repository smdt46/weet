//
//  loveMessageUserListViewController.swift
//  weet
//
//  Created by owner on 2019/02/01.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class loveMessageUserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = "恋愛"
    var myTableView1: UITableView!
    let matching = "love_favo_users"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if appDelegate.messageJson != nil {
            myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
            myTableView1.delegate = self
            myTableView1.dataSource = self
            myTableView1.estimatedRowHeight = 100
            myTableView1.rowHeight = 75
            self.view.addSubview(myTableView1)
        } else {
            errorAlert()
        }
    }
    
    // セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.messageJson![matching].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Message", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    // セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        
        cell.textLabel?.text = appDelegate.messageJson![matching][indexPath.row]["user_name"].stringValue
        cell.detailTextLabel?.text =
            appDelegate.messageJson![matching][indexPath.row]["age"].stringValue + "歳・" +
            appDelegate.messageJson![matching][indexPath.row]["residence"].stringValue
        
        let imageURL = URL(string: appDelegate.messageJson![matching][indexPath.row]["image1"].stringValue)
        do {
            let data = try Data(contentsOf: imageURL!)
            cell.imageView?.image = UIImage(data: data)
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        return cell
        
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
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
