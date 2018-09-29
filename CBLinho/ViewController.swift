//
//  ViewController.swift
//  CBLinho
//
//  Created by Ada 2018 on 27/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hungryLabel: UILabel!
    @IBOutlet weak var sleepyLabel: UILabel!
    @IBOutlet weak var dirtyLabel: UILabel!
    @IBOutlet weak var boringLabel: UILabel!
    
    var hungryStr = "1"
    var sleepyStr = "1"
    var dirtyStr = "1"
    var boringStr = "1"
    
    var cebelinho : Cebelinho?
    
    //backgroundTask
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CebelinhoPlay.start()
        CebelinhoPlay.loosingStatusByTime()
        cebelinho = CebelinhoPlay.getCebeliho()
        Timer.scheduledTimer(timeInterval: 0.2, target: self,
                             selector: #selector(updateUI), userInfo: nil, repeats: true)
        registerBackgroundTask()
        
        
    }
    
    
    @objc func updateUI(){
        switch UIApplication.shared.applicationState {
        case .active:
            self.hungryLabel.text = String((cebelinho?.hungry)!)
            self.sleepyLabel.text = String((cebelinho?.sleepy)!)
            self.boringLabel.text = String((cebelinho?.boring)!)
            self.dirtyLabel.text = String((cebelinho?.dirty)!)
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

}

