//
//  FuncAuxliares.swift
//  CBLinho
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import UIKit
class Animations {
    
    
    var select: [AnimationCase: [UIImage]] = [AnimationCase.padrao: [],
                                       AnimationCase.happy: [],
                                       AnimationCase.hungry: [],
                                       AnimationCase.sleepy: [],
                                       AnimationCase.dead: [],
                                       AnimationCase.dirty: [],
                                       AnimationCase.barFull: [],
                                       AnimationCase.barHalf: [],
                                       AnimationCase.almostBarEmpty: [],
                                       AnimationCase.almostBarFull: []]
    
    init() {
       
        self.select[AnimationCase.padrao]  = [#imageLiteral(resourceName: "default_sprite_0.png"),#imageLiteral(resourceName: "default_sprite_1.png"),#imageLiteral(resourceName: "default_sprite_2.png"),#imageLiteral(resourceName: "default_sprite_3.png"),#imageLiteral(resourceName: "default_sprite_4.png"),#imageLiteral(resourceName: "default_sprite_5.png"),#imageLiteral(resourceName: "default_sprite_6.png")]
        self.select[AnimationCase.happy]   = [#imageLiteral(resourceName: "happy_sprite_0.png"),#imageLiteral(resourceName: "happy_sprite_1.png"),#imageLiteral(resourceName: "happy_sprite_2.png"),#imageLiteral(resourceName: "happy_sprite_3.png"),#imageLiteral(resourceName: "happy_sprite_4.png"),#imageLiteral(resourceName: "happy_sprite_5.png"),#imageLiteral(resourceName: "happy_sprite_6.png"),#imageLiteral(resourceName: "happy_sprite_7.png")]
        self.select[AnimationCase.hungry]  = [#imageLiteral(resourceName: "hungry_sprite_0.png"),#imageLiteral(resourceName: "hungry_sprite_1.png"),#imageLiteral(resourceName: "hungry_sprite_2.png"),#imageLiteral(resourceName: "hungry_sprite_3.png"),#imageLiteral(resourceName: "hungry_sprite_4.png"),#imageLiteral(resourceName: "hungry_sprite_5.png")]
        self.select[AnimationCase.sleepy]  = [#imageLiteral(resourceName: "sleep_sprite_04.png"),#imageLiteral(resourceName: "sleep_sprite_05.png"),#imageLiteral(resourceName: "sleep_sprite_06.png"),#imageLiteral(resourceName: "sleep_sprite_07.png"),#imageLiteral(resourceName: "sleep_sprite_08.png"),#imageLiteral(resourceName: "sleep_sprite_09.png"),#imageLiteral(resourceName: "sleep_sprite_10.png"),#imageLiteral(resourceName: "sleep_sprite_11.png"),#imageLiteral(resourceName: "sleep_sprite_12.png"),#imageLiteral(resourceName: "sleep_sprite_13.png"),#imageLiteral(resourceName: "sleep_sprite_14.png"),#imageLiteral(resourceName: "sleep_sprite_15.png"),#imageLiteral(resourceName: "sleep_sprite_16.png"),#imageLiteral(resourceName: "sleep_sprite_17.png"),#imageLiteral(resourceName: "sleep_sprite_18.png"),#imageLiteral(resourceName: "sleep_sprite_19.png"),#imageLiteral(resourceName: "sleep_sprite_20.png")]
        self.select[AnimationCase.dead]    = [#imageLiteral(resourceName: "dead_sprite_00.png"),#imageLiteral(resourceName: "dead_sprite_01.png"),#imageLiteral(resourceName: "dead_sprite_02.png"),#imageLiteral(resourceName: "dead_sprite_03.png"),#imageLiteral(resourceName: "dead_sprite_04.png"),#imageLiteral(resourceName: "dead_sprite_05.png"),#imageLiteral(resourceName: "dead_sprite_06.png"),#imageLiteral(resourceName: "dead_sprite_07.png"),#imageLiteral(resourceName: "dead_sprite_08.png"),#imageLiteral(resourceName: "dead_sprite_09.png"),#imageLiteral(resourceName: "dead_sprite_10.png"),#imageLiteral(resourceName: "dead_sprite_11.png"),#imageLiteral(resourceName: "dead_sprite_12.png"),#imageLiteral(resourceName: "dead_sprite_13.png"),#imageLiteral(resourceName: "dead_sprite_14.png"),#imageLiteral(resourceName: "dead_sprite_15.png"),#imageLiteral(resourceName: "dead_sprite_16.png"),#imageLiteral(resourceName: "dead_sprite_17.png"),#imageLiteral(resourceName: "dead_sprite_18.png"),#imageLiteral(resourceName: "dead_sprite_19.png"),#imageLiteral(resourceName: "dead_sprite_20.png"),#imageLiteral(resourceName: "dead_sprite_21.png"),#imageLiteral(resourceName: "dead_sprite_22.png"),#imageLiteral(resourceName: "dead_sprite_23.png"),#imageLiteral(resourceName: "dead_sprite_24.png"),#imageLiteral(resourceName: "dead_sprite_25.png"),#imageLiteral(resourceName: "dead_sprite_26.png"),#imageLiteral(resourceName: "dead_sprite_27.png"),#imageLiteral(resourceName: "dead_sprite_28.png")]
        self.select[AnimationCase.dirty]   = [#imageLiteral(resourceName: "dirty_sprite_0.png"),#imageLiteral(resourceName: "dirty_sprite_1.png"),#imageLiteral(resourceName: "dirty_sprite_2.png"),#imageLiteral(resourceName: "dirty_sprite_3.png"),#imageLiteral(resourceName: "dirty_sprite_4.png"),#imageLiteral(resourceName: "dirty_sprite_5.png"),#imageLiteral(resourceName: "dirty_sprite_6.png"),#imageLiteral(resourceName: "dirty_sprite_7.png"),#imageLiteral(resourceName: "dirty_sprite_8.png")]
        self.select[AnimationCase.barFull] = [#imageLiteral(resourceName: "barFull_sprite_00.png"),#imageLiteral(resourceName: "barFull_sprite_01.png"),#imageLiteral(resourceName: "barFull_sprite_02.png"),#imageLiteral(resourceName: "barFull_sprite_03.png"),#imageLiteral(resourceName: "barFull_sprite_04.png"),#imageLiteral(resourceName: "barFull_sprite_05.png"),#imageLiteral(resourceName: "barFull_sprite_06.png"),#imageLiteral(resourceName: "barFull_sprite_07.png"),#imageLiteral(resourceName: "barFull_sprite_08.png"),#imageLiteral(resourceName: "barFull_sprite_09.png"),#imageLiteral(resourceName: "barFull_sprite_10.png"),#imageLiteral(resourceName: "barFull_sprite_11.png"),#imageLiteral(resourceName: "barFull_sprite_12.png"),#imageLiteral(resourceName: "barFull_sprite_13.png"),#imageLiteral(resourceName: "barFull_sprite_14.png"),#imageLiteral(resourceName: "barFull_sprite_15.png"),#imageLiteral(resourceName: "barFull_sprite_16.png"),#imageLiteral(resourceName: "barFull_sprite_17.png"),#imageLiteral(resourceName: "barFull_sprite_18.png"),#imageLiteral(resourceName: "barFull_sprite_19.png"),#imageLiteral(resourceName: "barFull_sprite_20.png"),#imageLiteral(resourceName: "barFull_sprite_21.png"),#imageLiteral(resourceName: "barFull_sprite_22.png")]
        self.select[AnimationCase.barHalf] = [#imageLiteral(resourceName: "barHalf_sprite_00.png"),#imageLiteral(resourceName: "barHalf_sprite_01.png"),#imageLiteral(resourceName: "barHalf_sprite_02.png"),#imageLiteral(resourceName: "barHalf_sprite_03.png"),#imageLiteral(resourceName: "barHalf_sprite_04.png"),#imageLiteral(resourceName: "barHalf_sprite_05.png"),#imageLiteral(resourceName: "barHalf_sprite_06.png"),#imageLiteral(resourceName: "barHalf_sprite_07.png"),#imageLiteral(resourceName: "barHalf_sprite_08.png"),#imageLiteral(resourceName: "barHalf_sprite_09.png"),#imageLiteral(resourceName: "barHalf_sprite_10.png"),#imageLiteral(resourceName: "barHalf_sprite_12.png"),#imageLiteral(resourceName: "barHalf_sprite_13.png"),#imageLiteral(resourceName: "barHalf_sprite_14.png"),#imageLiteral(resourceName: "barHalf_sprite_15.png"),#imageLiteral(resourceName: "barHalf_sprite_16.png"),#imageLiteral(resourceName: "barHalf_sprite_17.png"),#imageLiteral(resourceName: "barHalf_sprite_18.png")]
        self.select[AnimationCase.almostBarFull] = [#imageLiteral(resourceName: "almostBarFull_sprite_00.png"),#imageLiteral(resourceName: "almostBarFull_sprite_01.png"),#imageLiteral(resourceName: "almostBarFull_sprite_02.png"),#imageLiteral(resourceName: "almostBarFull_sprite_03.png"),#imageLiteral(resourceName: "almostBarFull_sprite_04.png"),#imageLiteral(resourceName: "almostBarFull_sprite_05.png"),#imageLiteral(resourceName: "almostBarFull_sprite_06.png"),#imageLiteral(resourceName: "almostBarFull_sprite_07.png"),#imageLiteral(resourceName: "almostBarFull_sprite_08.png"),#imageLiteral(resourceName: "almostBarFull_sprite_09.png"),#imageLiteral(resourceName: "almostBarFull_sprite_10.png"),#imageLiteral(resourceName: "almostBarFull_sprite_11.png"),#imageLiteral(resourceName: "almostBarFull_sprite_12.png"),#imageLiteral(resourceName: "almostBarFull_sprite_13.png"),#imageLiteral(resourceName: "almostBarFull_sprite_14.png"),#imageLiteral(resourceName: "almostBarFull_sprite_15.png"),#imageLiteral(resourceName: "almostBarFull_sprite_16.png"),#imageLiteral(resourceName: "almostBarFull_sprite_17.png"),#imageLiteral(resourceName: "almostBarFull_sprite_18.png"),#imageLiteral(resourceName: "almostBarFull_sprite_19.png"),#imageLiteral(resourceName: "almostBarFull_sprite_20.png")]
        self.select[AnimationCase.almostBarEmpty] = [#imageLiteral(resourceName: "almostBarEmpty_sprite_0.png"),#imageLiteral(resourceName: "almostBarEmpty_sprite_1.png"),#imageLiteral(resourceName: "almostBarEmpty_sprite_2.png"),#imageLiteral(resourceName: "almostBarEmpty_sprite_3.png")]
       
    }
   
   
    static func animationGiff(imagens: [UIImage],viewAnimation: UIImageView ){
        viewAnimation.animationImages = imagens
        viewAnimation.animationDuration = 1.5
        viewAnimation.startAnimating()
    }
}
