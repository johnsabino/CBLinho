//
//  Connectivity.swift
//  CBLinho
//
//  Created by João Paulo on 02/10/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import WatchKit
import WatchConnectivity

class Connectivity : NSObject, WCSessionDelegate {

    static var connectivity = Connectivity()
    
    private var session = WCSession.isSupported() ? WCSession.default : nil
    
    private override init() {
        super.init()
    }
    
    func startSession(){
        if WCSession.isSupported() {
            session?.delegate = self
            session?.activate()
        }
    }
    //send message to iPhone to sync core data
    func syncAttributes(){
        
        let cebelinho = CebelinhoPlay.getCebeliho()
        
        if (session?.isReachable)! {
            let bStr = String(cebelinho.boring)
            let hStr = String(cebelinho.hungry)
            let dStr = String(cebelinho.dirty)
            let sStr = String(cebelinho.sleepy)
            
            let firstTime = UserDefaults.standard.bool(forKey: "firstAccessWatch")
            
            let message : [String : Any] = ["Boring": bStr, "Hungry": hStr, "Sleepy": sStr,"Dirty": dStr, "lastModifyWatch": cebelinho.lastModifyWatch, "firstTimeWatch" : firstTime]
            
            print("enviando: ", message)
            WCSession.default.sendMessage(message, replyHandler: { (reply) in
                
                print("resposta: ",reply)
                
                cebelinho.boring = Double(reply["Boring"] as! String)!
                cebelinho.hungry = Double(reply["Hungry"] as! String)!
                cebelinho.dirty = Double(reply["Dirty"] as! String)!
                cebelinho.sleepy = Double(reply["Sleepy"] as! String)!
                
                UserDefaults.standard.setValue(false, forKey: "firstAccessWatch")
            }, errorHandler: { (error) in
                print(error)
            })
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }
    
    
}
