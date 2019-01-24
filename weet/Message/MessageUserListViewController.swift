//
//  MessageUserListViewController.swift
//  weet
//
//  Created by owner on 2019/01/25.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageUserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var myTableView1: UITableView!
    var json: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.json = appDelegate.userJson!
        
        myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.plain) // ‥②
        myTableView1.delegate = self // ‥③
        myTableView1.dataSource = self // ‥③
        myTableView1.estimatedRowHeight = 100
        myTableView1.rowHeight = 75
        self.view.addSubview(myTableView1)
    }
    
    // セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "message", sender: nil)
    }
    
    // セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("セルの値を入れていく")
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        
        cell.textLabel?.text = json!["user_basics"]["user_name"].stringValue
        cell.detailTextLabel?.text = json!["user_basics"]["age"].stringValue + "歳"
        
        let imageURL = URL(string: json!["user_basics"]["image1"].stringValue)
        do {
            let data = try Data(contentsOf: imageURL!)
            cell.imageView?.image = UIImage(data: data)
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
