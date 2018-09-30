//
//  NotificationController.swift
//  CBLinho WatchKit Extension
//
//  Created by Ada 2018 on 27/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class NotificationController: WKUserNotificationInterfaceController {
   
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    static func sendNotification(withTime: Double){
        let content = UNMutableNotificationContent()
        let notificationID = 1
        
        content.userInfo = ["NotificationID": notificationID]
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        
        //content.title = "Cebelinho"
        content.body = "Cebelinho need careful"
        content.sound = UNNotificationSound.default()
        
        // Time
        var trigger: UNTimeIntervalNotificationTrigger?
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: withTime, repeats: false)
        
        // Actions
        let snoozeAction = UNNotificationAction(identifier: "Care", title: "Care", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "UYLReminderCategory", actions: [snoozeAction], intentIdentifiers: [] as? [String] ?? [String](), options: .customDismissAction)
        let categories = Set<AnyHashable>([category])
        
        center.setNotificationCategories(categories as? Set<UNNotificationCategory> ?? Set<UNNotificationCategory>())
        
        content.categoryIdentifier = "UYLReminderCategory"
        
        let identifier: String = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: {(_ error: Error?) -> Void in
            if error != nil {
                print("ERRO: \(String(describing: error))")
            }
        })
        
    }
    
    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {

        completionHandler(.custom)
    }
 

    
}
