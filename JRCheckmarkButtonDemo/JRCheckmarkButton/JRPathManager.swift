//
//  JRPathManager.swift
//  ToppleTrack
//
//  Created by Joe Rocca on 8/29/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation
import UIKit

final class JRPathManager {
    
    //MARK: Properties
    public var size = CGFloat()
    
    //MARK: Paths
    public func pathForCheckmark() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.size/3.1578, y: self.size/2))
        path.addLine(to: CGPoint(x: self.size/2.0618, y: self.size/1.57894))
        path.addLine(to: CGPoint(x: self.size/1.3953, y: self.size/2.7272))
        return path
    }
    
    public func pathForPlus() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.size/3.0, y: self.size/2.0))
        path.addLine(to: CGPoint(x: self.size/1.5, y: self.size/2.0))
        path.move(to: CGPoint(x: self.size/2.0, y: self.size/3.0))
        path.addLine(to: CGPoint(x: self.size/2.0, y: self.size/1.5))
        return path
    }
    
    public func pathForButtonFrame() -> UIBezierPath {
        let radius = self.size / 2;
        let path = UIBezierPath(arcCenter: CGPoint(x: self.size/2, y: self.size/2),
                                radius: radius,
                                startAngle: CGFloat(0),
                                endAngle: CGFloat(2 * M_PI),
                                clockwise: true)
        return path
    }
}
