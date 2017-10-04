//
//  AppDelegate.swift
//  WongYiuNam-Doctor
//
//  Created by Phat Chiem on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        registerRemoteNotification(application)
        registerForPushNotifications(application)
        
        SVProgressHUD.setDefaultMaskType(.black)
        
        return true
    }
    
    //MARK: Push notification
    func registerForPushNotifications(_ application: UIApplication) {
        
        let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                              categories: nil)
        
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    func registerRemoteNotification(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_,_ in })
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
            
        }
        application.registerForRemoteNotifications()
    }
    
}
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        print("%@", remoteMessage.appData)
    }
    
}
