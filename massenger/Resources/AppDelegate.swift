//
//  AppDelegate.swift
//  massenger
//
//  Created by Ozan Öneyman on 22.07.2024.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

     func application(_ application: UIApplication,
       didFinishLaunchingWithOptions launchOptions:
                      [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
         FirebaseApp.configure()
       return true
     }


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}
