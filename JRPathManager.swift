//
//  JRPathManager.swift
//  ToppleTrack
//
//  Created by Joe Rocca on 8/29/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation

class JRPathManager {
    
    //MARK: Variables
    var size = CGFloat()
    
    //MARK: Paths
    func pathForCheckmark() -> UIBezierPath
    {
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(self.size/3.1578, self.size/2))
        path.addLineToPoint(CGPointMake(self.size/2.0618, self.size/1.57894))
        path.addLineToPoint(CGPointMake(self.size/1.3953, self.size/2.7272))
        return path
    }
    
    func pathForPlus() -> UIBezierPath
    {
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(self.size/3.0, self.size/2.0))
        path.addLineToPoint(CGPointMake(self.size/1.5, self.size/2.0))
        path.moveToPoint(CGPointMake(self.size/2.0, self.size/3.0))
        path.addLineToPoint(CGPointMake(self.size/2.0, self.size/1.5))
        return path
    }
    
    func pathForButtonFrame() -> UIBezierPath
    {
        let radius = self.size / 2;
        let path = UIBezierPath(arcCenter: CGPointMake(self.size/2, self.size/2),
                                radius: radius,
                                startAngle: CGFloat(0),
                                endAngle: CGFloat(2 * M_PI),
                                clockwise: true)
        
        return path
    }
    
}
