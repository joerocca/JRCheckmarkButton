//
//  JRAnimationManager.swift
//  ToppleTrack
//
//  Created by Joe Rocca on 8/29/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation

class JRAnimationManager {
    
    //MARK: Variables
    var animationDuration = Double()
    
    //MARK: Animation Builders
    func fillAnimationWithBounces(bounces: UInt, amplitude: CGFloat, reverse: Bool) -> CAKeyframeAnimation
    {
        var values = [NSValue]()
        var keyTimes = [NSNumber]()
        
        if reverse
        {
            values.append(NSValue(CATransform3D: CATransform3DMakeScale(1, 1, 1)))
        }
        else
        {
            values.append(NSValue(CATransform3D: CATransform3DMakeScale(0, 0, 0)))
        }
        
        keyTimes.append(0.0)
        
        for i in 1...bounces
        {
            let f = CGFloat(i)
            let scale = (f % 2) == 0 ? (1 + amplitude/f) : (1 - amplitude/f)
            let time = f * 1.0/CGFloat((bounces + 1))
            
            values.append(NSValue(CATransform3D: CATransform3DMakeScale(scale, scale, scale)))
            keyTimes.append(time)
        }
        
        if reverse
        {
            values.append(NSValue(CATransform3D: CATransform3DMakeScale(0.0001, 0.0001, 0.0001)))
        }
        else
        {
            values.append(NSValue(CATransform3D: CATransform3DMakeScale(1, 1, 1)))
        }
        
        keyTimes.append(1.0)
        
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = values
        animation.keyTimes = keyTimes
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.duration = self.animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
    
    func opacityAnimationReverse(reverse: Bool) -> CABasicAnimation
    {
        let animation = CABasicAnimation(keyPath: "opacity")
        if reverse
        {
            animation.fromValue = 1.0
            animation.toValue = 0.0
        }
        else
        {
            animation.fromValue = 0.0
            animation.toValue = 1.0
        }
        
        animation.duration = self.animationDuration
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
}
