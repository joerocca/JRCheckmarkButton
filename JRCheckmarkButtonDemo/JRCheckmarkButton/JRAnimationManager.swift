//
//  JRAnimationManager.swift
//  ToppleTrack
//
//  Created by Joe Rocca on 8/29/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation
import QuartzCore

final class JRAnimationManager {
    
    //MARK: Properties
    public var animationDuration = Double()
    
    //MARK: Animation Builders
    public func fillAnimationWithBounces(_ bounces: UInt, amplitude: CGFloat, reverse: Bool) -> CAKeyframeAnimation {
        var values = [NSValue]()
        var keyTimes = [NSNumber]()
        
        if reverse {
            values.append(NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1)))
        } else {
            values.append(NSValue(caTransform3D: CATransform3DMakeScale(0, 0, 0)))
        }
        
        keyTimes.append(0.0)
        
        for i in 1...bounces {
            let f = CGFloat(i)
            let scale = (f.truncatingRemainder(dividingBy: 2)) == 0 ? (1 + amplitude/f) : (1 - amplitude/f)
            let time = Float(f * 1.0/CGFloat((bounces + 1)))

            values.append(NSValue(caTransform3D: CATransform3DMakeScale(scale, scale, scale)))
            keyTimes.append(NSNumber(value: time))
        }
        
        if reverse {
            values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.0001, 0.0001, 0.0001)))
        }
        else {
            values.append(NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1)))
        }
        
        keyTimes.append(1.0)
        
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = values
        animation.keyTimes = keyTimes
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.duration = self.animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
    
    public func opacityAnimationReverse(_ reverse: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        if reverse {
            animation.fromValue = 1.0
            animation.toValue = 0.0
        } else {
            animation.fromValue = 0.0
            animation.toValue = 1.0
        }
        
        animation.duration = self.animationDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
}
