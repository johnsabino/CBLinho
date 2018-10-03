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
    var sleepBool: Bool = false
    
    var cebelinho : Cebelinho?
    
    //Watch Communication
    var lastMessage: CFAbsoluteTime = 0
    
    var boringStr = "100"
    var hungryStr = "100"
    var dirtyStr = "100"
    var sleepyStr = "100"
    
    var messageReceive : [String : String] = ["Boring": "100", "Hungry": "100", "Sleepy": "100","Dirty": "100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Carregar interface
        background.image = #imageLiteral(resourceName: "background")
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: happyBar)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation:sleepBar)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: hungryBar)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: showerBar)
        
        
        CebelinhoPlay.start()
        cebelinho = CebelinhoPlay.getCebeliho()
        Timer.scheduledTimer(timeInterval: 1, target: self,
                             selector: #selector(updateUI), userInfo: nil, repeats: true)
        
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    @objc func updateUI(){
      
            //boringStr = String((cebelinho?.boring)!)
            //hungryStr = String((cebelinho?.hungry)!)
            //dirtyStr = String((cebelinho?.dirty)!)
            //sleepyStr = String((cebelinho?.sleepy)!)
            
        
//            self.hungryLabel.text = hungryStr
//            self.sleepyLabel.text = sleepyStr
//            self.boringLabel.text = boringStr
//            self.dirtyLabel.text = dirtyStr
        
        updateStatusBars(attribute: .happy)
        updateStatusBars(attribute: .hungry)
        updateStatusBars(attribute: .shower)
        updateStatusBars(attribute: .sleep)
        
        if((cebelinho?.boring)! >= 35 && (cebelinho?.dirty)! >= 35 && (cebelinho?.hungry)! >= 35 && (cebelinho?.sleepy)! >= 35){
            
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
        }
    }
    
    func updateStatusBars(attribute : Attribute){
        
        var attrDouble = 0.0
        var viewAnim : UIImageView?
        var sadCBLinho : AnimationCase = .padrao
        
        switch attribute {
            case .happy:
                attrDouble = (cebelinho?.boring)!
                viewAnim = happyBar
            case .hungry:
                attrDouble = (cebelinho?.hungry)!
                viewAnim = hungryBar
                sadCBLinho = .hungry
            case .sleep:
                attrDouble = (cebelinho?.sleepy)!
                viewAnim = sleepBar
                sadCBLinho = .sleepy
            case .shower:
                attrDouble = (cebelinho?.dirty)!
                viewAnim = showerBar
                sadCBLinho = .dirty
        }
        
        if(attrDouble <= 100.0 && attrDouble >= 90.0){
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: viewAnim!)
            
        }else if(attrDouble <= 89 && attrDouble >= 60.0){
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.almostBarFull]!, viewAnimation: viewAnim!)
            
        }else if(attrDouble <= 59 && attrDouble >= 35){
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.barHalf]!, viewAnimation: viewAnim!)
            
            Animations.animationGiff(imagens: animacoes.select[sadCBLinho]!, viewAnimation: cebelinhoView)
            
        }else if(attrDouble <= 34 && attrDouble >= 0){
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.almostBarEmpty]!, viewAnimation: viewAnim!)
            
            Animations.animationGiff(imagens: animacoes.select[sadCBLinho]!, viewAnimation: cebelinhoView)
        }
        
        
        
    }
    
    func verificStatus(status: Double){
        
    }
    
    func sendWatchMessage() {
        
        // send a message to the watch if it's reachable
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
    
    @IBAction func play(_ sender: Any) {
        //give attributes and update animation
        self.sleepBool = true
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: happyBar)
        
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .happy)
        //send updates to watch
        sendWatchMessage()
        
    }
    @IBAction func toSleep(_ sender: Any) {
        
         self.sleepBool = !sleepBool
        
        if sleepBool == false {
             Animations.animationGiff(imagens: animacoes.select[AnimationCase.sleepy]!, viewAnimation: cebelinhoView)
        }else{
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
        }
        
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .sleep)
        sendWatchMessage()
        
    }
    
    @IBAction func giveShower(_ sender: Any) {
        self.sleepBool = true
        
        
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .shower)
        sendWatchMessage()
        
    }
    
    @IBAction func giveFood(_ sender: Any) {
        self.sleepBool = true
        
        
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: .hungry)
        sendWatchMessage()
    }
    

}
extension LifeCblinhoViewController: WCSessionDelegate {
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

    }
}


