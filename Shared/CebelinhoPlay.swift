//
//  CebelinhoPlay.swift
//  CBLinho
//
//  Created by João Paulo on 29/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import CoreData
import WatchKit

enum Attribute {
    case food
    case shower
    case play
    case sleep
}

enum Device {
    case phone
    case watch
}

class CebelinhoPlay {
    
    static var cebelinho : Cebelinho?
    
    static func start(){

        let fetch : NSFetchRequest<Cebelinho> = Cebelinho.fetchRequest()
        
        guard let _ = CoreDataManager.fetch(fetch).first else {
            print("criando novo...")
            let _ = Cebelinho()
            return
        }
    }
    
    static func getCebeliho() -> Cebelinho{
        let fetch : NSFetchRequest<Cebelinho> = Cebelinho.fetchRequest()
    
        let cebelinho = CoreDataManager.fetch(fetch).first
        
        return cebelinho!

    }
    
    static func loosingStatusByTime(device : Device){
        
        
        let fetch : NSFetchRequest<Cebelinho> = Cebelinho.fetchRequest()
        
        cebelinho = CoreDataManager.fetch(fetch).first
        
        var lastClosed : Double = 0.0
        
        switch device {
        case .phone:
            lastClosed = (cebelinho?.lastClosedIOS)!
        case .watch:
            lastClosed = (cebelinho?.lastClosedWatch)!
        }
        
        let statusLosted = CFAbsoluteTimeGetCurrent() - lastClosed
        
        cebelinho?.boring -= statusLosted
        cebelinho?.dirty -= statusLosted
        cebelinho?.hungry -= statusLosted
        cebelinho?.sleepy -= statusLosted
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            if(cebelinho!.boring > 0){
                cebelinho?.boring -= 1
            }else{
                cebelinho?.boring = 0
            }
            
            if(cebelinho!.dirty > 0){
                cebelinho?.dirty -= 1
            }else{
                cebelinho?.dirty = 0
            }
            
            if (cebelinho!.hungry > 0){
                cebelinho?.hungry -= 1
            }else{
                cebelinho?.hungry = 0
            }
            
            if(cebelinho!.sleepy > 0){
                cebelinho?.sleepy -= 1
            }else{
                cebelinho?.sleepy = 0
            }
            
//            if (WCSession.default.isReachable) {
//                // this is a meaningless message, but it's enough for our purposes
//                let message = ["Boring": boringStr, "Hungry": hungryStr, "Sleepy": sleepyStr,"Dirty": dirtyStr]
//                WCSession.default.sendMessage(message, replyHandler: nil)
//            }

        }
    }

    static func getLowerAttribute() -> Double{
        var array: [Double] = []
 
        array.append((cebelinho?.boring)!)
        array.append((cebelinho?.dirty)!)
        array.append((cebelinho?.sleepy)!)
        array.append((cebelinho?.hungry)!)
        array.sort()
        
        return array.first!

    }
    
    static func giveAttributes(attr : Attribute){
        
        switch attr {
        case .food:
            cebelinho?.hungry = 100
        case .shower:
            cebelinho?.dirty = 100
        case .play:
            cebelinho?.boring = 100
        case .sleep:
            cebelinho?.sleepy = 100
        
        }
    }

    
    
    static func syncAttributes(message: [String : String]){
        let cebelinho = self.getCebeliho()
        //["Boring": "100", "Hungry": "100", "Sleepy": "100","Dirty": "100"]
        cebelinho.boring = Double(message["Boring"]!)!
        cebelinho.dirty = Double(message["Dirty"]!)!
        cebelinho.hungry = Double(message["Hungry"]!)!
        cebelinho.sleepy = Double(message["Sleepy"]!)!
        

    }
    
    
}
