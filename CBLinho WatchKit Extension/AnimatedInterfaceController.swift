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


class AnimatedInterfaceController: WKInterfaceController{
    


    @IBOutlet var imageAnimatedGroup: WKInterfaceGroup!
    
    
    @IBOutlet var playLabel: WKInterfaceLabel!
    @IBOutlet var sleepLabel: WKInterfaceLabel!
    @IBOutlet var showerLabel: WKInterfaceLabel!
    @IBOutlet var hungryLabel: WKInterfaceLabel!
    
    
    var cebelinho : Cebelinho?
    
    var boringStr = "100"
    var hungryStr = "100"
    var dirtyStr = "100"
    var sleepyStr = "100"
     
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        imageAnimatedGroup.setBackgroundImageNamed("AnimationWatch")
        imageAnimatedGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10), duration: 1.5, repeatCount: -1)
        
        
        //setup initial configs
        CebelinhoPlay.start()
        cebelinho = CebelinhoPlay.getCebeliho()
        
        //timer to update UI
        Timer.scheduledTimer(timeInterval: 1, target: self,
                             selector: #selector(updateUI), userInfo: nil, repeats: true)
        
        //verify if WCSession is supported to assign delegate and activate
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    @objc func updateUI(){
        
        boringStr = String(format : "%.0f", (cebelinho?.boring)!)
        hungryStr = String(format : "%.0f",(cebelinho?.hungry)!)
        dirtyStr = String(format : "%.0f",(cebelinho?.dirty)!)
        sleepyStr = String(format : "%.0f",(cebelinho?.sleepy)!)
        
        self.hungryLabel.setText(hungryStr)
        self.sleepLabel.setText(sleepyStr)
        self.playLabel.setText(boringStr)
        self.showerLabel.setText(dirtyStr)
        
    }
    
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //buttons to give attributes
    @IBAction func giveFood() {
        self.hungryLabel.setText(hungryStr)
        clickGiveAttributes(attr: .hungry)
      
    }
    @IBAction func giveShower() {
        self.showerLabel.setText(dirtyStr)
        clickGiveAttributes(attr: .shower)
    }
    @IBAction func play() {
        self.playLabel.setText(boringStr)
        clickGiveAttributes(attr: .happy)
      
    }
    @IBAction func sleep() {
        self.sleepLabel.setText(sleepyStr)
        clickGiveAttributes(attr: .sleep)
        
    }
    
    //give attributes when click in the buttons
    func clickGiveAttributes(attr : Attribute){
        cebelinho?.lastModifyWatch = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: attr)
        Connectivity.connectivity.sendMessage()
    }

}

//Connectivity with iPhone
extension AnimatedInterfaceController : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        Connectivity.connectivity.sendMessage()
    }
    
    //when receive message from iPhone, update core data
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        cebelinho?.boring = Double(message["Boring"] as! String)!
        cebelinho?.hungry = Double(message["Hungry"] as! String)!
        cebelinho?.dirty = Double(message["Dirty"] as! String)!
        cebelinho?.sleepy = Double(message["Sleepy"] as! String)!
        
    }
    
}

