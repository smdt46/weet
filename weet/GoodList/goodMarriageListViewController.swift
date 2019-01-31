//
//  goodMarriageListViewController.swift
//  weet
//
//  Created by owner on 2019/01/31.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class goodMarriageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = "婚活"
    var myTableView1: UITableView!
    var json: JSON?
    let userList = ["8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.userJson != nil {
            self.json = appDelegate.userJson!
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択したユーザーIDをGETし、ユーザーページに遷移する
        let url: String = "http://54.238.92.95:8080/api/v1/user/\(userList[indexPath.row])"
        Alamofire.request(url).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.userJson = JSON(object)
            let storyboard: UIStoryboard = UIStoryboard(name: "UserPage", bundle: nil)
            let next: UIViewController = storyboard.instantiateInitialViewController()!
            self.navigationController?.pushViewController(next, animated: true)
            print("AppDelegate Request")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let url: String = "http://54.238.92.95:8080/api/v1/user/\(userList[indexPath.row])"
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        Alamofire.request(url).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            
            
            let userjson = JSON(object)
            
            cell.textLabel?.text = userjson["user_basics"]["user_name"].stringValue
            cell.detailTextLabel?.text = userjson["user_basics"]["age"].stringValue + "歳"
            
            let imageURL = URL(string: userjson["user_basics"]["image1"].stringValue)
            do {
                let data = try Data(contentsOf: imageURL!)
                cell.imageView?.image = UIImage(data: data)
            }catch let err {
                print("Error : \(err.localizedDescription)")
            }
            
            
            print("AppDelegate Request")
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
    }

}
