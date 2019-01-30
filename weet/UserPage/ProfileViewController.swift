//
//  ProfileViewController.swift
//  weet
//
//  Created by owner on 2019/01/22.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  IndicatorInfoProvider {

    var myTableView1: UITableView!
    
    var json: JSON = []
    var itemInfo: IndicatorInfo = "プロフィール"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.json = appDelegate.userJson!
        
        let tableSize = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 3000.0)
        myTableView1 = UITableView(frame: tableSize, style: UITableView.Style.grouped)
        myTableView1.delegate = self
        myTableView1.dataSource = self
        myTableView1.estimatedRowHeight = 100
        myTableView1.allowsSelection = false
        myTableView1.isScrollEnabled = false
        myTableView1.rowHeight = UITableView.automaticDimension
        self.view.addSubview(myTableView1)
    }
    
    // セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        if json["user_specials"].count != 0 {
            //print("セクション数: \(3 + json["user_specials"].count)")
            // (ひとこと + 自己紹介) + 質問カテゴリ
            return 2 + json["user_specials"].count
        } else {
            //print("セクション数: 1")
            return 1
        }
    }
    
    // セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ひとこと"
        } else if section == 1 {
            return "コメント"
        } else {
            return json["user_specials"][section - 2]["matching_format_name"].stringValue
        }
    }
    
    
    // セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("セル数：1")
        switch section {
        case 0,1:
            return 1
        default:
            return json["user_specials"][section - 2]["user_questions_and_answers"].count
        }
        //return 1
    }
    
    // セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 通常セルの準備
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        
        if indexPath.section == 0 {
            cell.textLabel?.text = json["user_basics"]["hitokoto"].stringValue
        } else if indexPath.section == 1 {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = json["user_basics"]["comment"].stringValue
        } else {
            cell.detailTextLabel?.numberOfLines = 0
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.black
            cell.textLabel?.text = json["user_specials"][indexPath.section-2]["user_questions_and_answers"][indexPath.row]["question_name"].stringValue
            cell.detailTextLabel?.text = json["user_specials"][indexPath.section-2]["user_questions_and_answers"][indexPath.row]["answer_name"].stringValue
        }
        
        // 強調表示（テスト用）
        if ((indexPath.section == 2 && indexPath.row == 0) ||
            (indexPath.section == 3 && indexPath.row == 0) ||
            (indexPath.section == 4 && indexPath.row == 0)) {
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
