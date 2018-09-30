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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }

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
