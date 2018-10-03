//
//  NotificationController.swift
//  CBLinho
//
//  Created by Ada 2018 on 02/10/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//


import UserNotifications

class NotificationController {
    
    static var center = UNUserNotificationCenter.current()
    static var options : UNAuthorizationOptions = [.alert, .sound]
    
    
    static func requestAuthorizationNotification(){
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
    }
    
    //schedule notification
    //this notification is for users take care of Cebelinho
    static func scheduleNotification(withTime : Double){

        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Cebelinho needs care!"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: withTime,
                                                        repeats: false)
    
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
        })
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "UYLDeleteAction",
                                                title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: "UYLReminderCategory",
                                              actions: [snoozeAction,deleteAction],
                                              intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
        content.categoryIdentifier = "UYLReminderCategory"
    }
}
