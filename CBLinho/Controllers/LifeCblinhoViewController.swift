//
//  LifeCblinhoViewController.swift
//  CBLinho
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class LifeCblinhoViewController: UIViewController {

    let image = [#imageLiteral(resourceName: "sprite_00.png"),#imageLiteral(resourceName: "sprite_00.png"),#imageLiteral(resourceName: "sprite_01.png"),#imageLiteral(resourceName: "sprite_02.png"),#imageLiteral(resourceName: "sprite_03.png"),#imageLiteral(resourceName: "sprite_04.png"),#imageLiteral(resourceName: "sprite_05.png"),#imageLiteral(resourceName: "sprite_06.png"),#imageLiteral(resourceName: "sprite_07.png"),#imageLiteral(resourceName: "sprite_08.png"),#imageLiteral(resourceName: "sprite_09.png"),#imageLiteral(resourceName: "sprite_10.png"),#imageLiteral(resourceName: "sprite_11.png"),#imageLiteral(resourceName: "sprite_12.png"),#imageLiteral(resourceName: "sprite_13.png"),#imageLiteral(resourceName: "sprite_14.png"),#imageLiteral(resourceName: "sprite_15.png"),#imageLiteral(resourceName: "sprite_16.png"),#imageLiteral(resourceName: "sprite_17.png"),#imageLiteral(resourceName: "sprite_18.png"),#imageLiteral(resourceName: "sprite_19.png"),#imageLiteral(resourceName: "sprite_20.png")]
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var cebelinho: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FuncAux.animationGiff(imagens: image, viewAnimation: cebelinho)
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
