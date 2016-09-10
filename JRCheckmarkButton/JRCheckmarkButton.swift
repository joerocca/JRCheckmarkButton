//
//  CheckmarkButton.swift
//  ToppleTrack
//
//  Created by Joe Rocca on 8/22/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class JRCheckmarkButton: UIControl, CAAnimationDelegate {
    
    //MARK: Variables
    
    //General Variables
    var checked: Bool = false
    var lineWidth: CGFloat = 3.5
    var animationDuration: Double = 0.3
    var checkedTintColor: UIColor = UIColor(red:0.59, green:0.79, blue:0.18, alpha:1.0)
    var checkedFillColor: UIColor = UIColor(red:0.59, green:0.79, blue:0.18, alpha:1.0)
    var checkedCheckColor: UIColor = UIColor.whiteColor()
    var uncheckedTintColor: UIColor = UIColor.lightGrayColor()
    
    let animationManager = JRAnimationManager()
    let pathManager = JRPathManager()
    
    //UIElement Variables
    var onBoxLayer: CAShapeLayer?
    var offBoxLayer: CAShapeLayer?
    var checkmarkLayer: CAShapeLayer?
    var plusLayer: CAShapeLayer?
    
    //MARK: Initialization
    
    init()
    {
        super.init(frame: CGRectZero)
        
        self.configureView()
        self.configureAnimationManager()
    }
    
    init(options: [JRCheckmarkButtonOption]?)
    {
        super.init(frame: CGRectZero)
        
        if options != nil
        {
            self.configureOptions(options)
        }
        self.configureView()
        self.configureAnimationManager()
    }
    
    init(frame: CGRect, options: [JRCheckmarkButtonOption]?)
    {
        super.init(frame: frame)
        
        if options != nil
        {
            self.configureOptions(options)
        }
        self.configureView()
        self.configureAnimationManager()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect)
    {
        self.setButtonChecked(false, animated: false)
    }
    
    override func layoutSubviews()
    {
        self.pathManager.size = self.frame.size.height
        
        super.layoutSubviews()
    }
    
    
    //MARK: Configuration
    
    private func configureOptions(options: [JRCheckmarkButtonOption]!)
    {
        for option in options!
        {
            switch (option)
            {
                case let .LineWidth(value):
                    self.lineWidth = value
                case let .AnimationDuration(value):
                    self.animationDuration = value
                case let .CheckedTintColor(value):
                    self.checkedTintColor = value
                case let .CheckedFillColor(value):
                    self.checkedFillColor = value
                case let .CheckedCheckColor(value):
                    self.checkedCheckColor = value
                case let .UncheckedTintColor(value):
                    self.uncheckedTintColor = value
            }
            
        }
    }
    
    private func configureView()
    {
        self.backgroundColor = UIColor.clearColor()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
    }
    
    private func configureAnimationManager()
    {
        self.animationManager.animationDuration = self.animationDuration
    }
    
    //MARK: Button Management

    func setButtonChecked(checked: Bool, animated: Bool)
    {
        self.checked = checked
        
        self.drawEntireCheckbox()
        
        
        if checked == true
        {
            if animated == true
            {
                self.addCheckedAnimation()
            }
        }
        else
        {
            if animated == true
            {
                self.addUncheckedAnimation()
            }
            else
            {
                self.onBoxLayer?.removeFromSuperlayer()
                self.checkmarkLayer?.removeFromSuperlayer()
            }
        }
    }
    
    
    func drawEntireCheckbox()
    {
        if self.offBoxLayer == nil || CGPathGetBoundingBox(self.offBoxLayer!.path!).size.height == 0.0
        {
            self.drawOffButton()
            self.drawPlus()
        }
        
        if self.checked
        {
            self.drawOnButton()
            self.drawCheckmark()
        }
    }
    
    
    //MARK: Drawers
    

    func drawOnButton()
    {
        self.onBoxLayer?.removeFromSuperlayer()
        self.onBoxLayer = CAShapeLayer()
        self.onBoxLayer!.frame = self.bounds
        self.onBoxLayer!.path = self.pathManager.pathForButtonFrame().CGPath
        self.onBoxLayer!.lineWidth = self.lineWidth
        self.onBoxLayer!.fillColor = self.checkedFillColor.CGColor
        self.onBoxLayer!.strokeColor = self.checkedTintColor.CGColor
        self.onBoxLayer!.rasterizationScale = 2.0 * UIScreen.mainScreen().scale
        self.onBoxLayer!.shouldRasterize = true
        self.layer.addSublayer(self.onBoxLayer!)
    }
    
    func drawOffButton()
    {
        self.offBoxLayer?.removeFromSuperlayer()
        self.offBoxLayer = CAShapeLayer()
        self.offBoxLayer!.frame = self.bounds
        self.offBoxLayer!.path = self.pathManager.pathForButtonFrame().CGPath
        self.offBoxLayer!.fillColor = UIColor.clearColor().CGColor
        self.offBoxLayer!.strokeColor = self.uncheckedTintColor.CGColor
        self.offBoxLayer!.lineWidth = self.lineWidth
        
        self.offBoxLayer!.rasterizationScale = 2.0 * UIScreen.mainScreen().scale
        self.offBoxLayer!.shouldRasterize = true
        
        self.layer.addSublayer(self.offBoxLayer!)
    }
    
    func drawPlus()
    {
        self.plusLayer?.removeFromSuperlayer()
        self.plusLayer = CAShapeLayer()
        self.plusLayer!.frame = self.bounds
        self.plusLayer!.path = self.pathManager.pathForPlus().CGPath
        self.plusLayer!.fillColor = UIColor.clearColor().CGColor
        self.plusLayer!.strokeColor = self.uncheckedTintColor.CGColor
        self.plusLayer!.lineWidth = self.lineWidth
        self.plusLayer!.lineCap = kCALineCapRound
        self.plusLayer!.lineJoin = kCALineJoinRound
        
        self.plusLayer!.rasterizationScale = 2.0 * UIScreen.mainScreen().scale
        self.plusLayer!.shouldRasterize = true
        self.layer.addSublayer(self.plusLayer!)
    }
    
    func drawCheckmark()
    {
        self.checkmarkLayer?.removeFromSuperlayer()
        self.checkmarkLayer = CAShapeLayer()
        self.checkmarkLayer!.frame = self.bounds
        self.checkmarkLayer!.path = self.pathManager.pathForCheckmark().CGPath
        self.checkmarkLayer!.strokeColor = self.checkedCheckColor.CGColor
        self.checkmarkLayer!.lineWidth = self.lineWidth
        self.checkmarkLayer!.fillColor = UIColor.clearColor().CGColor
        self.checkmarkLayer!.lineCap = kCALineCapRound
        self.checkmarkLayer!.lineJoin = kCALineJoinRound
        
        self.checkmarkLayer!.rasterizationScale = 2.0 * UIScreen.mainScreen().scale
        self.checkmarkLayer!.shouldRasterize = true
        self.layer.addSublayer(self.checkmarkLayer!)
    }
    
    func handleTapGesture(recognizer: UITapGestureRecognizer)
    {
        self.setButtonChecked(!self.checked, animated: true)
        self.sendActionsForControlEvents(.TouchUpInside)
    }
    
    private func addCheckedAnimation()
    {
        let wiggle = self.animationManager.fillAnimationWithBounces(2, amplitude: 0.35, reverse: false)
        wiggle.delegate = self
        
        let opacityAnimation = self.animationManager.opacityAnimationReverse(false)
        opacityAnimation.duration = Double(self.animationDuration / 1.4)
        
        self.onBoxLayer!.addAnimation(opacityAnimation, forKey: "opacity")
        self.checkmarkLayer!.addAnimation(wiggle, forKey: "transform")
    }
    
    private func addUncheckedAnimation()
    {
        let wiggle = self.animationManager.fillAnimationWithBounces(1, amplitude: 0.35, reverse: true)
        wiggle.duration = Double(self.animationDuration / 1.1)
        let opacity = self.animationManager.opacityAnimationReverse(true)
        opacity.delegate = self
        
        self.onBoxLayer!.addAnimation(opacity, forKey: "opacity")
        self.checkmarkLayer!.addAnimation(wiggle, forKey: "transform")
    }


    //MARK: CAAnimation Delegate
    
    func animationDidStop(anim: CAAnimation, finished flag: Bool)
    {
        if (self.checked == false)
        {
            self.onBoxLayer!.removeFromSuperlayer()
            self.checkmarkLayer!.removeFromSuperlayer()
        }
        
    }
    
}
