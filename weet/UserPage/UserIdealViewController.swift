//
//  UserIdealViewController.swift
//  weet
//
//  Created by owner on 2019/01/22.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import SwiftyJSON
import XLPagerTabStrip

class UserIdealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {

    var itemInfo: IndicatorInfo = "私の理想像"
    var json: JSON = []
    var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        if appDelegate.myJson != nil {
            self.json = appDelegate.userJson!
            
            myTableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
            myTableView.delegate = self
            myTableView.dataSource = self
            myTableView.estimatedRowHeight = 100
            myTableView.allowsSelection = false
            myTableView.rowHeight = 75
            myTableView.isScrollEnabled = false
            self.view.addSubview(myTableView)
        } else {
            print("接続エラー")
        }
        
    }
    
    // セクション数の指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return json["user_ideal_specials"].count
    }
    
    // セクションタイトルの設定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return json["user_ideal_specials"][section]["matching_format_name"].stringValue
    }
    
    // セル数の指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json["user_ideal_specials"][section]["user_ideal_questions_and_answers"].count
    }
    
    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        
        cell.textLabel?.textColor = UIColor.gray
        cell.textLabel?.text = json["user_ideal_specials"][indexPath.section]["user_ideal_questions_and_answers"][indexPath.row]["ideal_question_name"].stringValue
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = UIColor.black
        cell.detailTextLabel?.text = json["user_ideal_specials"][indexPath.section]["user_ideal_questions_and_answers"][indexPath.row]["ideal_answer_name"].stringValue
        
        if ((indexPath.section == 0 && indexPath.row == 0) ||
        (indexPath.section == 1 && indexPath.row == 0) ||
            (indexPath.section == 2 && indexPath.row == 0)) {
            cell.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1)
        }
        
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
