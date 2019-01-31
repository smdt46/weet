//
//  AppDelegate.swift
//  weet
//
//  Created by owner on 2019/01/06.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var myJson: JSON?
    var userJson: JSON?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyboardName: String = "Main"
        var viewName: String
        
        // ログイン中であればメインのタブメニューへ、そうでなければタイトル画面へ遷移
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
            viewName = "tabMain"
        } else {
            viewName = "title"
        }
        let storybord: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = storybord.instantiateViewController(withIdentifier: viewName)
        window!.makeKeyAndVisible()
        
        let url1: String = "http://54.238.92.95:8080/api/v1/user/3"
        Alamofire.request(url1).responseJSON { response in
            guard let object = response.result.value else {
                return
            }

            self.myJson = JSON(object)
            print("AppDelegate Request")
        }
        
        let url2: String = "http://54.238.92.95:8080/api/v1/user/2"
        Alamofire.request(url2).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            
            self.userJson = JSON(object)
            print("AppDelegate Request")
        }
        
        FirebaseApp.configure()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

