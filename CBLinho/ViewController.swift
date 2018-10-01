//
//  ViewController.swift
//  CBLinho
//
//  Created by Ada 2018 on 27/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
    
    @IBOutlet weak var hungryLabel: UILabel!
    @IBOutlet weak var sleepyLabel: UILabel!
    @IBOutlet weak var dirtyLabel: UILabel!
    @IBOutlet weak var boringLabel: UILabel!
    
    
    
    var cebelinho : Cebelinho?
    
    //Watch Communication
    var lastMessage: CFAbsoluteTime = 0

    var boringStr = "100"
    var hungryStr = "100"
    var dirtyStr = "100"
    var sleepyStr = "100"
    
    var messageReceive : [String : String] = ["Boring": "100", "Hungry": "100", "Sleepy": "100","Dirty": "100"]
    //backgroundTask
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CebelinhoPlay.start()
        CebelinhoPlay.loosingStatusByTime()
        cebelinho = CebelinhoPlay.getCebeliho()
        Timer.scheduledTimer(timeInterval: 2, target: self,
                             selector: #selector(updateUI), userInfo: nil, repeats: true)
        registerBackgroundTask()
        
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
    }
    
    @objc func updateUI(){
        switch UIApplication.shared.applicationState {
        case .active:
            
            boringStr = String((cebelinho?.boring)!)
            hungryStr = String((cebelinho?.hungry)!)
            dirtyStr = String((cebelinho?.dirty)!)
            sleepyStr = String((cebelinho?.sleepy)!)
            
            self.hungryLabel.text = hungryStr
            self.sleepyLabel.text = sleepyStr
            self.boringLabel.text = boringStr
            self.dirtyLabel.text = dirtyStr
            
            sendWatchMessage()
        case .background:
            print("App is backgrounded. Cebelinho hungry = \((cebelinho?.hungry)!)")
            print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
        case .inactive:
            break
        }
        
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    func sendWatchMessage() {
        
//        let currentTime = CFAbsoluteTimeGetCurrent()
//
//        // if less than half a second has passed, bail out
//        if lastMessage + 0.5 > currentTime {
//            return
//        }
        
        // send a message to the watch if it's reachable
        if (WCSession.default.isReachable) {
            // this is a meaningless message, but it's enough for our purposes
            let message = ["Boring": boringStr, "Hungry": hungryStr, "Sleepy": sleepyStr,"Dirty": dirtyStr]
            WCSession.default.sendMessage(message, replyHandler: nil)
        }
        
        // update our rate limiting property
       // lastMessage = CFAbsoluteTimeGetCurrent()
    }

    @IBAction func giveFood(_ sender: Any) {
        CebelinhoPlay.giveAttributes(attr: .food)
    }
    @IBAction func sleep(_ sender: Any) {
        CebelinhoPlay.giveAttributes(attr: .sleep)
        
    }
    @IBAction func giveShower(_ sender: Any) {
        CebelinhoPlay.giveAttributes(attr: .shower)
        
    }
    @IBAction func play(_ sender: Any) {
        CebelinhoPlay.giveAttributes(attr: .play)
    }
    
}

extension ViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        messageReceive = message as! [String : String]
        print("recebendo mensagem: ", messageReceive)
    }
}

