//
//  ChoiceViewController.swift
//  weet
//
//  Created by Taro Kimura on 2019/01/22.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChoiceViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var matching_format_id:Int = 1
    
    struct UserBasics: Codable {
        let user_name : String
        let sex : String
        let age : Int
        let matching_format_name : String
        let image1 : String
        let image3 : String
        let hitokoto : String
        let residence : String
        let image2 : String
        let comment : String
    }
    struct UserQuestionsAndAnswers:Codable{
        let question_name : String
        let answer_name: String
        let question_id : Int
    }
    
    struct UserSpecials:Codable{
        let user_questions_and_answers :[UserQuestionsAndAnswers]
        let matching_format_name :String
    }
    
    struct UserIdealQuestionsAndAnswers:Codable{
        let ideal_question_name : String
        let ideal_question_id : Int
        let ideal_answer_name : String
    }
    
    struct UserIdealSpecials:Codable{
        let user_ideal_questions_and_answers : [UserIdealQuestionsAndAnswers]
        let matching_format_name :String
    }
    struct Result:Codable{
        let user_specials :[UserSpecials]
        let user_basics : UserBasics
        let user_ideal_specials : [UserIdealSpecials]
    }
    
    func requestUserData(){
        do {
            print(matching_format_id)
            // API URL_
            let api_url:String = "http://54.238.92.95:8080/api/v1/matching/player/"+appDelegate.playerID+"/matching-format/"+String(matching_format_id)
            // APIにアクセス
            let url = URL(string: api_url)!
            let data = try Data(contentsOf: url, options: [])
            // jsonに変換後パース
            let json = try JSON(data: data)
            appDelegate.userJson = try JSON(data: data)
            let resultData:Result = try JSONDecoder().decode(Result.self, from: data)
            
            let image_url = URL(string: resultData.user_basics.image1)!
            
            // imageViewを更新
            let imageData = try Data(contentsOf: image_url)
            let image = UIImage(data:imageData)
            imageView.image=image
            // ラベル更新
            userNameLabel.text=resultData.user_basics.user_name
            userInfoLabel.text=resultData.user_basics.hitokoto
            print(resultData.user_basics.hitokoto)
        } catch {
            errorAlert()
            print(error)
        }
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
        print("tapped")
        let storyboard: UIStoryboard = UIStoryboard(name: "UserPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "userMain") as! UserPageViewController
        vc.matchingFormatID = matching_format_id
        vc.postType = "favo"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func swipe(_ sender:
        UISwipeGestureRecognizer) {
        requestUserData()
    }
    
    func errorAlert() {
        let title = "ユーザーが見つかりませんでした"
        let message = "条件を変えてください"
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch matching_format_id {
        case 1:
            self.title = "友達マッチング"
        case 2:
            self.title = "恋愛マッチング"
        case 3:
            self.title = "婚活マッチング"
        case 4:
            self.title = "ルームメイトマッチング"
        default:
            self.title = "マッチング画面"
        }
        requestUserData()
        // 画像をタップすることを可能に
        self.imageView.isUserInteractionEnabled = true
        
        // 画像をタップされたときのアクションを追加
        self.imageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(self.tapped(sender:)))
        )
    }
    
    
}

