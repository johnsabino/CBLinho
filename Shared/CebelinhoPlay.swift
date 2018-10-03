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
    case hungry
    case shower
    case happy
    case sleep
}

enum Device {
    case phone
    case watch
}

class CebelinhoPlay {
    
    static var cebelinho : Cebelinho?
    static var timer : Timer?
    
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
    
    static func loosingStatusByTime(){
        
        
        let fetch : NSFetchRequest<Cebelinho> = Cebelinho.fetchRequest()
        
        cebelinho = CoreDataManager.fetch(fetch).first
        
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
           
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
        }
    }
    
    static func updateAttributesOnActive(device : Device){
        var lastClosed : Double = 0.0
        var lastModify1 : Double = 0.0
        var lastModify2 : Double = 0.0
        switch device {
        case .phone:
            lastClosed = (cebelinho?.lastClosedIOS)!
            lastModify1 = (cebelinho?.lastModifyIOS)!
            lastModify2 = (cebelinho?.lastModifyWatch)!
        case .watch:
            lastClosed = (cebelinho?.lastClosedWatch)!
            lastModify1 = (cebelinho?.lastModifyWatch)!
            lastModify2 = (cebelinho?.lastModifyIOS)!
        }
        

        if lastClosed > 0 && lastModify1 > lastModify2{
            let statusLosted = CFAbsoluteTimeGetCurrent() - lastClosed

            cebelinho?.boring -= statusLosted
            cebelinho?.dirty -= statusLosted
            cebelinho?.hungry -= statusLosted
            cebelinho?.sleepy -= statusLosted
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
        case .hungry:
            cebelinho?.hungry = 100
        case .shower:
            cebelinho?.dirty = 100
        case .happy:
            cebelinho?.boring = 100
        case .sleep:
            cebelinho?.sleepy = 100
        
        }
    }
   
    
}
