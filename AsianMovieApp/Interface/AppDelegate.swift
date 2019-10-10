//
//  AppDelegate.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 08/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard_Main : UIStoryboard?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    class func sharedInstance()-> AppDelegate {
           return UIApplication.shared.delegate as! AppDelegate
       }
       
       func get_StoryboardMain_Instance()->UIStoryboard{
           if  self.storyboard_Main == nil {
               self.storyboard_Main = UIStoryboard.init(name: "Main", bundle: nil)
           }
           return self.storyboard_Main!
       }


}

