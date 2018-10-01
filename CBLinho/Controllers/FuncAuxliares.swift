//
//  FuncAuxliares.swift
//  CBLinho
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import UIKit
class FuncAux {
   static func animationGiff(imagens: [UIImage],viewAnimation: UIImageView ){
        viewAnimation.animationImages = imagens
        viewAnimation.animationDuration = 1.5
        viewAnimation.startAnimating()
    }
}
