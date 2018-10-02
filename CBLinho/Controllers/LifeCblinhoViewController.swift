//
//  LifeCblinhoViewController.swift
//  CBLinho
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class LifeCblinhoViewController: UIViewController {

    
    @IBOutlet weak var happyBar: UIImageView!
    @IBOutlet weak var sleepBar: UIImageView!
    @IBOutlet weak var hungryBar: UIImageView!
    @IBOutlet weak var showerBar: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var cebelinho: UIImageView!
    
    
 
    let animacoes = Animations.init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.image = #imageLiteral(resourceName: "background")
        
       
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.dead]!, viewAnimation: cebelinho)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: happyBar)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation:sleepBar)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: hungryBar)
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: showerBar)

       
        // Do any additional setup after loading the view.
    }

    @IBAction func play(_ sender: Any) {
        Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: happyBar)
        
    }
    @IBAction func toSleep(_ sender: Any) {
         Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation:sleepBar)
    }
    
    @IBAction func giveShower(_ sender: Any) {
          Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: showerBar)
    }
    
    @IBAction func giveFood(_ sender: Any) {
         Animations.animationGiff(imagens: animacoes.select[AnimationCase.barFull]!, viewAnimation: hungryBar)
    }
    

}
