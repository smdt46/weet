//
//  UserProfileViewController.swift
//  weet
//
//  Created by owner on 2019/01/09.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import XLPagerTabStrip

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {
    
    
    var myTableView1: UITableView!
    
    // メモリに保存したユーザーIDを変数に取り込む
    // let userID = UserDefaults.standard.string(forKey: "userID")
    
    var json: JSON = []
    var image1Name: String = ""
    var itemInfo: IndicatorInfo = "プロフィール"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        
        myTableView1.register(UINib(nibName: "UserImagePreviewTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        myTableView1.delegate = self
        myTableView1.dataSource = self
        myTableView1.estimatedRowHeight = 100
        myTableView1.allowsSelection = false
        myTableView1.isScrollEnabled = false
        myTableView1.rowHeight = UITableView.automaticDimension
        self.view.addSubview(myTableView1)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.json = appDelegate.myJson!
        // getProfile()
    }
    
    
    // API
//    func getProfile() {
//
//
//        // ユーザIDをURLのパラメータに設定して問い合わせる
//
//
//        let url: String = "http://54.238.92.95:8080/api/v1/user/1"
//        Alamofire.request(url).responseJSON { response in
//            guard let object = response.result.value else {
//                return
//            }
//
//            self.json = JSON(object)
//            print("request")
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.myJson = self.json
//            self.myTableView1.reloadData()
//        }
//    }
    
    
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
        

        // 基本情報セルの準備
//        let imageCell = myTableView1.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! UserImagePreviewTableViewCell

        // ユーザー画像が空欄の場合デフォルト画像を設定する
//        let defaultImage = ""
//        if self.json["user_basics"]["image1"].stringValue !=  ""{
//            self.image1Name = self.json["user_basics"]["image1"].stringValue
//        }

        // ユーザー基本情報の場合
        if indexPath.section == 0 {
            cell.textLabel?.text = json["user_basics"]["hitokoto"].stringValue
            return cell
        } else if indexPath.section == 1 {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = json["user_basics"]["comment"].stringValue
            return cell
        } else {
            cell.detailTextLabel?.numberOfLines = 0
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.black
            cell.textLabel?.text = json["user_specials"][indexPath.section-2]["user_questions_and_answers"][indexPath.row]["question_name"].stringValue
            cell.detailTextLabel?.text = json["user_specials"][indexPath.section-2]["user_questions_and_answers"][indexPath.row]["answer_name"].stringValue
            return cell
        }

        //cell.detailTextLabel?.numberOfLines = 0
        //cell.detailTextLabel?.text = textArry[indexPath.row]
        //return imageCell
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
