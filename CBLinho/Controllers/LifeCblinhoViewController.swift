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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Carregar interface
        background.image = #imageLiteral(resourceName: "background")
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: happyBar)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation:sleepBar)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: hungryBar)
        
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: showerBar)
        
        
        //setup initial configs
        CebelinhoPlay.start()
        cebelinho = CebelinhoPlay.getCebeliho()
        
        //timer to update UI
        Timer.scheduledTimer(timeInterval: 1, target: self,
                             selector: #selector(updateUI), userInfo: nil, repeats: true)
        
        //verify if WCSession is supported to assign delegate and activate
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    @objc func updateUI(){
        
        updateStatusBars(attribute: .happy)
        updateStatusBars(attribute: .hungry)
        updateStatusBars(attribute: .shower)
        updateStatusBars(attribute: .sleep)
        
        if((cebelinho?.boring)! >= 60 && (cebelinho?.dirty)! >= 60 && (cebelinho?.hungry)! >= 60 && (cebelinho?.sleepy)! >= 60){
            
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
            
        }else if((cebelinho?.boring)! < 34 && (cebelinho?.dirty)! < 34 && (cebelinho?.hungry)! < 34 && (cebelinho?.sleepy)! < 34){
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.dead]!, viewAnimation: cebelinhoView)
        }
        
    }
    
    //Update status bar(attributes) and animations
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
    
    
    //buttons to give attributes
    @IBAction func play(_ sender: Any) {
        self.sleepBool = true
        clickGiveAttributes(attr: .happy)
    }
    @IBAction func toSleep(_ sender: Any) {
         self.sleepBool = !sleepBool
        if sleepBool == false {
             Animations.animationGiff(imagens: animacoes.select[AnimationCase.sleepy]!, viewAnimation: cebelinhoView)
        }else{
            Animations.animationGiff(imagens: animacoes.select[AnimationCase.padrao]!, viewAnimation: cebelinhoView)
        }
        clickGiveAttributes(attr: .sleep)
    }
    
    @IBAction func giveShower(_ sender: Any) {
        self.sleepBool = true
        
        clickGiveAttributes(attr: .shower)
        
    }
    
    @IBAction func giveFood(_ sender: Any) {
        self.sleepBool = true
        clickGiveAttributes(attr: .hungry)
    }
    
    //give attributes when click in the buttons
    func clickGiveAttributes(attr : Attribute){
        cebelinho?.lastModifyIOS = CFAbsoluteTimeGetCurrent()
        CebelinhoPlay.giveAttributes(attr: attr)
        sendWatchMessage()
    }

}

//Connectivity with watchOS
extension LifeCblinhoViewController: WCSessionDelegate {
    
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
    
    
    //When receive watch message, reply to sync core data
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        let lastModifyWatch = message["lastModifyWatch"] as! Double
        let firstTimeWatch = message["firstTimeWatch"] as! Bool
        
        print(lastModifyWatch , " - ", (cebelinho?.lastModifyIOS)!)
        
        //if the last modify was in watch, so get the attributes and let equals in the iOS app
        if lastModifyWatch > (cebelinho?.lastModifyIOS)! || firstTimeWatch == true{
            
            cebelinho?.boring = Double(message["Boring"] as! String)!
            cebelinho?.hungry = Double(message["Hungry"] as! String)!
            cebelinho?.dirty = Double(message["Dirty"] as! String)!
            cebelinho?.sleepy = Double(message["Sleepy"] as! String)!
            
        }
        
        //else, get the attributes of iOS App and send to watch 
        let bStr = String((cebelinho?.boring)!)
        let hStr = String((cebelinho?.hungry)!)
        let dStr = String((cebelinho?.dirty)!)
        let sStr = String((cebelinho?.sleepy)!)
        
        let reply = ["Boring": bStr, "Hungry": hStr, "Sleepy": sStr,"Dirty": dStr, "lastModifyIOS": String(CFAbsoluteTimeGetCurrent())]
        
        replyHandler(reply)

    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}


