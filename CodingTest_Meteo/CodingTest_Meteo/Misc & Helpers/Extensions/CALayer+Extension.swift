//
//  CALayer+Extension.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func fade(duration: TimeInterval) {
        let transition: CATransition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        add(transition, forKey: "fade")
    }
    
    func scale(duration: TimeInterval) {
        let transition: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        transition.fromValue = 0.75 // Your from value (not obvious from the question)
        transition.toValue = 1.0
        transition.duration = 2 * duration / 3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        add(transition, forKey: "scale")
    }
}
