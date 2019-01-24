//
//  ChoiceViewController.swift
//  weet
//
//  Created by Taro Kimura on 2019/01/22.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    var i:Int=0
  
    struct UserData{
        let user_name:String
        let image1:String
        let image2:String
        let image3:String
        let sex:String
        let age:Int
        let residence:String
        let hitokoto:String
    }
    var userDatum = [UserData]()
    
    
    @IBAction func swipe(_ sender:
        UISwipeGestureRecognizer) {
        var imageArray=["ain.jpg","rose.jpg","jihyo.jpg","joy.jpg","ueeda.jpg","ueeda2.jpg"]
        var userNames=["Ain","Rose","Jihyo","Joy","かずもり","あつもり"]
        if(5<i){
            i=0
        }
        
        let mainImage = UIImage(named:imageArray[i] )
        
        if(userNameLabel.isHidden){
           userNameLabel.isHidden = false
        }
        
        if(userInfoLabel.isHidden){
            userNameLabel.isHidden = false
        }
        
        if(imageView.isHidden){
            imageView.isHidden = false
        }
        
        if(shadowView.isHidden){
            shadowView.isHidden = false
        }
        
        
        userNameLabel.text=userNames[i]
        i=i+1
        imageView.image=mainImage
    }
    
    @IBAction func testButton(_ sender: Any) {
        let url = URL(string: "https://scontent-nrt1-1.cdninstagram.com/vp/3fcdc4f29441516e2c26f727b5c951ad/5CC3F919/t51.2885-15/e35/31788447_1964211993895171_3814348962245115904_n.jpg?_nc_ht=scontent-nrt1-1.cdninstagram.com")!
        do {
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data:imageData)
            imageView.image=image
        } catch {
            let title = "Error"
            let message = "Sorry, image is not available."
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okayButton)
            
            present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.isHidden = true
        userInfoLabel.isHidden = true
        imageView.isHidden = true
        shadowView.isHidden = true
    }
    
    
}

