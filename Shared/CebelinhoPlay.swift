//
//  CebelinhoPlay.swift
//  CBLinho
//
//  Created by João Paulo on 29/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import CoreData

class CebelinhoPlay {
    
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
        
        let cebelinho = CoreDataManager.fetch(fetch).first
        
        cebelinho?.boring = 100
        cebelinho?.dirty = 100
        cebelinho?.hungry = 100
        cebelinho?.sleepy = 100
        
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
    
    static func syncAttributes(){
        let fetch : NSFetchRequest<Cebelinho> = Cebelinho.fetchRequest()
        
        let cebelinho = CoreDataManager.fetch(fetch).first
        print(CoreDataManager.fetch(fetch))
        
    }
    
    
}
