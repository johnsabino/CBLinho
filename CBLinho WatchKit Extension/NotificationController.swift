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
        
    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {

        completionHandler(.custom)
    }
 

    
}
