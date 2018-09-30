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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        CebelinhoPlay.start()
        CebelinhoPlay.loosingStatusByTime()
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
        hungryStr = String((cebelinho?.hungry)!)
        dirtyStr = String((cebelinho?.dirty)!)
        sleepyStr = String((cebelinho?.sleepy)!)
        
        self.hungryLabel.setText(hungryStr)
        self.sleepyLabel.setText(sleepyStr)
        self.boringLabel.setText(boringStr)
        self.dirtyLabel.setText(dirtyStr)
        
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
    
}
extension InterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let attr = message
        print("recebendo mensagem: ", attr)
        
    }
}
