//
//  AppDelegate.swift
//  CBLinho
//
//  Created by Ada 2018 on 27/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
   
  
    func applicationDidFinishLaunching(_ application: UIApplication) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        
        NotificationController.requestAuthorizationNotification()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        //invalidade timer and save states
        CebelinhoPlay.timer?.invalidate()
        
        let cebelinho = CebelinhoPlay.getCebeliho()
        print("salvando ultima vez que o app do iOS ficou inativo")
        cebelinho.lastClosedIOS = CFAbsoluteTimeGetCurrent()

        
        //schedule notification when apps resign active
        //this notification is for users take care of Cebelinho
        //calculate the lowerAttribute of Cebelhinho, then cauculate the time for notification
        let lowerAttribute = CebelinhoPlay.getLowerAttribute()/2
        var timeLeft = Int(lowerAttribute)
        print(Double(lowerAttribute/2))
        
        if timeLeft <= 1{
            timeLeft = 10
        }
        
        NotificationController.scheduleNotification(withTime: Double(timeLeft))
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("ENTERING BACKGROUND")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //start Cebelinho
        CebelinhoPlay.start()
        CebelinhoPlay.loosingStatusByTime()
        CebelinhoPlay.updateAttributesOnActive(device: .phone)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        CoreDataManager.saveContext()
    }



}

