//
//  IdealViewController.swift
//  weet
//
//  Created by owner on 2019/01/17.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

class IdealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = "私の理想像"
    var json: JSON = []
    var myTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自分の情報が入ったJSONを取り込む
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.json = appDelegate.myJson!
        
        myTableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 100
        myTableView.allowsSelection = false
        myTableView.rowHeight = 75
        myTableView.isScrollEnabled = false
        self.view.addSubview(myTableView)
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
        
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
