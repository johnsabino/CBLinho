//
//  LifeCblinhoViewController.swift
//  CBLinho
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import WatchConnectivity

class LifeCblinhoViewController: UIViewController {

    
    @IBOutlet weak var happyBar: UIImageView!
    @IBOutlet weak var sleepBar: UIImageView!
    @IBOutlet weak var hungryBar: UIImageView!
    @IBOutlet weak var showerBar: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var cebelinhoView: UIImageView!
    
    let animacoes = Animations.init()
    var sleep: Bool = false
    
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
        //Carregar interface
        background.image = #imageLiteral(resourceName: "background")
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: happyBar)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation:sleepBar)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: hungryBar)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: showerBar)
        
        
        
        //CebelinhoPlay.loosingStatusByTime()
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
            
            
            
//            self.hungryLabel.text = hungryStr
//            self.sleepyLabel.text = sleepyStr
//            self.boringLabel.text = boringStr
//            self.dirtyLabel.text = dirtyStr
            
        // sendWatchMessage()
        case .background:
            print("App is backgrounded. Cebelinho hungry = \((cebelinho?.hungry)!)")
            print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
        case .inactive:
            break
        }
        
    }
    func verificStatus(status: Double){
        
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
            
            
            let bStr = String((cebelinho?.boring)!)
            let hStr = String((cebelinho?.hungry)!)
            let dStr = String((cebelinho?.dirty)!)
            let sStr = String((cebelinho?.sleepy)!)
            
            let message = ["Boring": bStr, "Hungry": hStr, "Sleepy": sStr,"Dirty": dStr, "lastModifyWatch": String((cebelinho?.lastModifyWatch)!)]
            
            WCSession.default.sendMessage(message, replyHandler: nil) { (error) in
                print(error)
            }
            //            WCSession.default.sendMessage(message, replyHandler: { (reply) in
            //                self.messageLabel.text = reply.first?.value as? String
            //                print("resposta: ",reply)
            //            }, errorHandler: { (error) in
            //                print(error)
            //            })
            
            print("starting watch app")
            
            
        }
        
        // update our rate limiting property
        // lastMessage = CFAbsoluteTimeGetCurrent()
    }
    @IBAction func play(_ sender: Any) {
        self.sleep = true
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: happyBar)
        
    }
    @IBAction func toSleep(_ sender: Any) {
         self.sleep = !sleep
         Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation:sleepBar)
        if sleep == false {
             Animations.animationGiff(imagens: animacoes.select[AnimationCase.sleepy]!, viewAnimation: cebelinhoView)
        }else{
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
        }
        
    }
    
    @IBAction func giveShower(_ sender: Any) {
        self.sleep = true
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: showerBar)
        
    }
    
    @IBAction func giveFood(_ sender: Any) {
        self.sleep = true
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: hungryBar)
    }
    

}
extension LifeCblinhoViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    //    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
    //
    //        DispatchQueue.main.async {
    //            self.messageLabel.text = (applicationContext.first?.value) as? String
    //        }
    //
    //        print("Mensagem recebida ", (applicationContext.first?.value)!)
    //    }
    
    //    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    //        messageReceive = message as! [String : String]
    //        print("recebendo mensagem: ", messageReceive)
    //    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        let lastModifyWatch = Double(message["lastModifyWatch"] as! String)!
        
        
        cebelinho?.lastModifyWatch = lastModifyWatch
        
        if lastModifyWatch > (cebelinho?.lastModifyIOS)!{
            
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


