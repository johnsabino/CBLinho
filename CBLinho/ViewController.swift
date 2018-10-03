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
    
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var messageReceive : [String : String] = ["Boring": "100", "Hungry": "100", "Sleepy": "100","Dirty": "100"]
    //backgroundTask
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CebelinhoPlay.start()
        
        cebelinho = CebelinhoPlay.getCebeliho()
        Timer.scheduledTimer(timeInterval: 1, target: self,
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
        
        if (WCSession.default.isReachable) {
            
            let bStr = String((cebelinho?.boring)!)
            let hStr = String((cebelinho?.hungry)!)
            let dStr = String((cebelinho?.dirty)!)
            let sStr = String((cebelinho?.sleepy)!)
            
            let message = ["Boring": bStr, "Hungry": hStr, "Sleepy": sStr,"Dirty": dStr, "lastModifyWatch": String((cebelinho?.lastModifyWatch)!)]
            
            WCSession.default.sendMessage(message, replyHandler: nil) { (error) in
                print(error)
            }
        
        

        }

    }

    @IBAction func giveFood(_ sender: Any) {
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .hungry)
        sendWatchMessage()
    }
    @IBAction func sleep(_ sender: Any) {
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .sleep)
        sendWatchMessage()
    }
    @IBAction func giveShower(_ sender: Any) {
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .shower)
        sendWatchMessage()
    }
    @IBAction func play(_ sender: Any) {
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .happy)
        sendWatchMessage()
    }
    
    @IBAction func getResponse(_ sender: Any) {
  
    }
}

extension ViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
        
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        let lastModifyWatch = message["lastModifyWatch"] as! Double
        
        
        //cebelinho?.lastModifyWatch = lastModifyWatch
        
        print(lastModifyWatch , " - ", (cebelinho?.lastModifyIOS)!)
        if lastModifyWatch > (cebelinho?.lastModifyIOS)! || message["firstTimeWatch"] as! Bool == true{
            
            
            cebelinho?.boring = Double(message["Boring"] as! String)!
            cebelinho?.hungry = Double(message["Hungry"] as! String)!
            cebelinho?.dirty = Double(message["Dirty"] as! String)!
            cebelinho?.sleepy = Double(message["Sleepy"] as! String)!
            
        }
        
        let bStr = String((cebelinho?.boring)!)
        let hStr = String((cebelinho?.hungry)!)
        let dStr = String((cebelinho?.dirty)!)
        let sStr = String((cebelinho?.sleepy)!)
        
        let reply = ["Boring": bStr, "Hungry": hStr, "Sleepy": sStr,"Dirty": dStr, "lastModifyIOS": String(CFAbsoluteTimeGetCurrent())]
        
        replyHandler(reply)
        

        //replyHandler(["Resposta": "RESPONDIDO"])
    }
}

