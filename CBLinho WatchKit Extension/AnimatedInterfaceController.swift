//
//  AnimatedInterfaceController.swift
//  CBLinho WatchKit Extension
//
//  Created by Ada 2018 on 02/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import CoreData
import WatchConnectivity


class AnimatedInterfaceController: WKInterfaceController,  WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    

    
    @IBOutlet var imageAnimatedGroup: WKInterfaceGroup!
    
    
    var cebelinho : Cebelinho?
    
    var boringStr = "100"
    var hungryStr = "100"
    var dirtyStr = "100"
    var sleepyStr = "100"
    var messageReceive : [String : String] = ["Boring": "100", "Hungry": "100", "Sleepy": "100","Dirty": "100"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        imageAnimatedGroup.setBackgroundImageNamed("AnimationWatch")
        imageAnimatedGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10), duration: 1.5, repeatCount: -1)
        
        
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
        boringStr = String((cebelinho?.boring)!)
        //boringStr = messageReceive["Boring"]!
        hungryStr = String((cebelinho?.hungry)!)
        //hungryStr = messageReceive["Hungry"]!
        dirtyStr = String((cebelinho?.dirty)!)
        //dirtyStr = messageReceive["Sleepy"]!
        sleepyStr = String((cebelinho?.sleepy)!)
        //sleepyStr = messageReceive["Dirty"]!
        
        
        
        //sendWatchMessage()
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
            
            //let date = CFAbsoluteTimeGetCurrent()
            
            let bStr = String((cebelinho?.boring)!)
            let hStr = String((cebelinho?.hungry)!)
            let dStr = String((cebelinho?.dirty)!)
            let sStr = String((cebelinho?.sleepy)!)
            
            let message = ["Boring": bStr, "Hungry": hStr, "Sleepy": sStr,"Dirty": dStr, "lastModifyWatch": String((cebelinho?.lastModifyWatch)!)]
            
            print("enviando: ", message)
            WCSession.default.sendMessage(message, replyHandler: { (reply) in
                
                print("resposta: ",reply)
                
                self.cebelinho?.boring = Double(reply["Boring"] as! String)!
                self.cebelinho?.hungry = Double(reply["Hungry"] as! String)!
                self.cebelinho?.dirty = Double(reply["Dirty"] as! String)!
                self.cebelinho?.sleepy = Double(reply["Sleepy"] as! String)!
                
                
            }, errorHandler: { (error) in
                print(error)
            })
            
        }
        
        // update our rate limiting property
        // lastMessage = CFAbsoluteTimeGetCurrent()
    }
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func giveFood() {
        cebelinho?.lastModifyWatch = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .food)
        sendWatchMessage()
    }
    @IBAction func giveShower() {
        cebelinho?.lastModifyWatch = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .shower)
        sendWatchMessage()
    }
    @IBAction func play() {
        cebelinho?.lastModifyWatch = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .play)
        sendWatchMessage()
    }
    @IBAction func sleep() {
        cebelinho?.lastModifyWatch = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .sleep)
        sendWatchMessage()
    }

}

