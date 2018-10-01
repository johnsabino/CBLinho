//
//  InterfaceController.swift
//  CBLinho WatchKit Extension
//
//  Created by Ada 2018 on 27/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    var cebelinho : Cebelinho?
    
    @IBOutlet var hungryLabel: WKInterfaceLabel!
    @IBOutlet var dirtyLabel: WKInterfaceLabel!
    @IBOutlet var boringLabel: WKInterfaceLabel!
    @IBOutlet var sleepyLabel: WKInterfaceLabel!
    
    var boringStr = "100"
    var hungryStr = "100"
    var dirtyStr = "100"
    var sleepyStr = "100"
    var messageReceive : [String : String] = ["Boring": "100", "Hungry": "100", "Sleepy": "100","Dirty": "100"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        CebelinhoPlay.start()
        //CebelinhoPlay.loosingStatusByTime()
        cebelinho = CebelinhoPlay.getCebeliho()
        Timer.scheduledTimer(timeInterval: 2, target: self,
                             selector: #selector(updateUI), userInfo: nil, repeats: true)
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }

    }
    
    @objc func updateUI(){
       // boringStr = String((cebelinho?.boring)!)
        boringStr = messageReceive["Boring"]!
       // hungryStr = String((cebelinho?.hungry)!)
        hungryStr = messageReceive["Hungry"]!
       // dirtyStr = String((cebelinho?.dirty)!)
        dirtyStr = messageReceive["Sleepy"]!
       // sleepyStr = String((cebelinho?.sleepy)!)
        sleepyStr = messageReceive["Dirty"]!
        self.hungryLabel.setText(hungryStr)
        self.sleepyLabel.setText(sleepyStr)
        self.boringLabel.setText(boringStr)
        self.dirtyLabel.setText(dirtyStr)
        
        sendWatchMessage()
    }
    
    
    @IBAction func giveFood() {
        CebelinhoPlay.giveAttributes(attr: .food)
        self.hungryLabel.setText(String((cebelinho?.hungry)!))
    }
    @IBAction func giveShower() {
        CebelinhoPlay.giveAttributes(attr: .shower)
        self.dirtyLabel.setText(String((cebelinho?.dirty)!))
    }
    @IBAction func play() {
        CebelinhoPlay.giveAttributes(attr: .play)
        self.boringLabel.setText(String((cebelinho?.boring)!))
    }
    @IBAction func sleep() {
        CebelinhoPlay.giveAttributes(attr: .sleep)
        self.sleepyLabel.setText(String((cebelinho?.sleepy)!))
    }
    
    
    
    override func willActivate() {
        
        super.willActivate()
    }
    
    override func didDeactivate() {
        
        super.didDeactivate()
    }

    @IBAction func sendNot() {
        
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
            
            let message = ["Boring": "TESTING MESSAGE"]
            print(message)
         
            WCSession.default.sendMessage(message, replyHandler: nil)
        }
        
        // update our rate limiting property
        // lastMessage = CFAbsoluteTimeGetCurrent()
    }
    
}
extension InterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func sessionReachabilityDidChange(_ session: WCSession) {
        if (!session.isReachable){
            CebelinhoPlay.syncAttributes(message: messageReceive)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        messageReceive = message as! [String : String]
        print("recebendo mensagem: ", messageReceive)
        
    }
}
