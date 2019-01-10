//
//  UserProfileViewController.swift
//  weet
//
//  Created by owner on 2019/01/09.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView1: UITableView!
    let textArry: [String] = ["1番めのセル","2番めのセル",
                              "3番めのセルは長い文字列を設定して、\nセルの高さが自動的に調節されるようになるかを確認しようと思います。",
                              "4番目のセル","5番目のセル"]
    let sectionTitleArry: [String] = ["基本情報", "ひとこと", "自己紹介", "友達関連", "恋愛関係", "婚活関係", "ルームメイト関係"]
    
    let friendArry: [String] = ["居住地", "学歴", "職業", "暮らし"]
    let friendAnsArry: [String] = ["兵庫県", "高校卒", "システムエンジニア", "実家暮らし"]
    
    let loveArry: [String] = ["恋愛対象(性別)", "恋愛対象(年齢)", "デートの頻度"]
    let loveAnsArry: [String] = ["女性", "18〜30", "未設定"]
    
    let marriageArry: [String] = ["年収", "結婚歴", "子供はいますか"]
    let marriageAnsArry: [String] = ["300万〜500万", "なし", "なし"]
    
    let roommateArry: [String] = ["目的は？", "期間は？", "部屋はどうする？"]
    let roommateAnsArry: [String] = ["未設定", "未設定", "未設定"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        myTableView1.register(UINib(nibName: "UserImagePreviewTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        myTableView1.delegate = self
        myTableView1.dataSource = self
        myTableView1.estimatedRowHeight = 100
        myTableView1.allowsSelection = false
        myTableView1.rowHeight = UITableView.automaticDimension
        //myTableView1.isScrollEnabled = false
        self.view.addSubview(myTableView1)
    }
    
    // セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArry.count
    }
    
    // セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArry[section]
    }
    

    // セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2:
            return 1
        case 3:
            return friendArry.count
        case 4:
            return loveArry.count
        case 5:
            return marriageArry.count
        case 6:
            return roommateArry.count
        default:
            return 0
        }
    }
    
    // セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        let cellImage = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! UserImagePreviewTableViewCell
        
        switch indexPath.section {
        case 0:
            cellImage.cellViewData(image1Name: "pose_furikaeru_man.png", image2Name: "pose_furikaeru_man.png", image3Name: "pose_furikaeru_man.png", name: "かまやんかまやん", ageAndAddress: "22歳・兵庫県")
            return cellImage
        case 1:
            cell.textLabel?.text = "いいご縁を期待してます"
        case 2:
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "私はシステムエンジニアをしています\nあああああ"
        case 3:
            cell.detailTextLabel?.textColor = UIColor.magenta
            cell.textLabel?.text = friendArry[indexPath.row]
            cell.detailTextLabel?.text = friendAnsArry[indexPath.row]
        case 4:
            cell.detailTextLabel?.textColor = UIColor.magenta
            cell.textLabel?.text = loveArry[indexPath.row]
            cell.detailTextLabel?.text = loveAnsArry[indexPath.row]
        case 5:
            cell.detailTextLabel?.textColor = UIColor.magenta
            cell.textLabel?.text = marriageArry[indexPath.row]
            cell.detailTextLabel?.text = marriageAnsArry[indexPath.row]
        case 6:
            cell.detailTextLabel?.textColor = UIColor.magenta
            cell.textLabel?.text = roommateArry[indexPath.row]
            cell.detailTextLabel?.text = roommateAnsArry[indexPath.row]
        default:
            break
        }
        
//        print("aaa\(indexPath.section)-\(indexPath.row)")
//
//        // セルタイトル
//        cell.textLabel?.textColor = UIColor.gray
//        cell.textLabel?.text = "セクション番号:\(indexPath.section)"
//        // セル内容
//        cell.detailTextLabel?.textColor = UIColor.darkGray
//        cell.detailTextLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
