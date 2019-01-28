//
//  goodListViewController.swift
//  weet
//
//  Created by owner on 2019/01/27.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import SwiftyJSON

class goodListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var myTableView1: UITableView!
    var json: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.json = appDelegate.userJson!
        
        myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
        myTableView1.delegate = self
        myTableView1.dataSource = self
        myTableView1.estimatedRowHeight = 100
        myTableView1.rowHeight = 75
        self.view.addSubview(myTableView1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "UserPage", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()!
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
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
    }
}
