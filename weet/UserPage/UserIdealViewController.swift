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
        
        
        if appDelegate.userJson != nil {
            self.json = appDelegate.userJson!
            
            let tableSize = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 3000.0)
            myTableView = UITableView(frame: tableSize, style: UITableView.Style.grouped)
            myTableView.delegate = self
            myTableView.dataSource = self
            myTableView.estimatedRowHeight = 100
            myTableView.allowsSelection = false
            myTableView.rowHeight = 60
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
        
        if ((indexPath.section == 0 && indexPath.row == 1) ||
            (indexPath.section == 0 && indexPath.row == 3) ||
            (indexPath.section == 0 && indexPath.row == 4) ||
            (indexPath.section == 0 && indexPath.row == 5) ||
            (indexPath.section == 0 && indexPath.row == 7) ||
            (indexPath.section == 0 && indexPath.row == 9) ||
            (indexPath.section == 0 && indexPath.row == 12) ||
            (indexPath.section == 1 && indexPath.row == 0) ||
            (indexPath.section == 1 && indexPath.row == 1) ||
            (indexPath.section == 1 && indexPath.row == 2) ||
            (indexPath.section == 1 && indexPath.row == 3) ||
            (indexPath.section == 1 && indexPath.row == 5) ||
            (indexPath.section == 2 && indexPath.row == 0) ||
            (indexPath.section == 2 && indexPath.row == 1) ||
            (indexPath.section == 2 && indexPath.row == 2) ||
            (indexPath.section == 2 && indexPath.row == 5) ||
            (indexPath.section == 2 && indexPath.row == 6) ||
            (indexPath.section == 3 && indexPath.row == 1)) {
            cell.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1)
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
