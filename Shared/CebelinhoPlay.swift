//
//  CebelinhoPlay.swift
//  CBLinho
//
//  Created by João Paulo on 29/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import CoreData

enum Attribute {
    case food
    case shower
    case play
    case sleep
}

class CebelinhoPlay {
    
    static var cebelinho : Cebelinho?
    
    static func start(){

        let fetch : NSFetchRequest<Cebelinho> = Cebelinho.fetchRequest()
        
        guard let _ = CoreDataManager.fetch(fetch).first else {
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

        }
    }

    static func getLowerAttribute() -> Int{
        var array: [Int] = []
 
        array.append(Int((cebelinho?.boring)!))
        array.append(Int((cebelinho?.dirty)!))
        array.append(Int((cebelinho?.sleepy)!))
        array.append(Int((cebelinho?.hungry)!))
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

    
    
//    static func syncAttributes(){
//        let fetch : NSFetchRequest<Cebelinho> = Cebelinho.fetchRequest()
//
//        let cebelinho = CoreDataManager.fetch(fetch).first
//        print(CoreDataManager.fetch(fetch))
//
//    }
    
    
}
