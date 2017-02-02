//
//  CheckmarkButton.swift
//  ToppleTrack
//
//  Created by Joe Rocca on 8/22/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

final class JRCheckmarkButton: UIControl {
    
    //MARK: Properties
    public private(set) var checked: Bool = false
    public private(set) var lineWidth: CGFloat = 3.5
    public private(set) var animationDuration: Double = 0.3
    public private(set) var checkedTintColor: UIColor = UIColor(red:0.59, green:0.79, blue:0.18, alpha:1.0)
    public private(set) var checkedFillColor: UIColor = UIColor(red:0.59, green:0.79, blue:0.18, alpha:1.0)
    public private(set) var checkedCheckColor: UIColor = UIColor.white
    public private(set) var uncheckedTintColor: UIColor = UIColor.lightGray
    
    private let animationManager = JRAnimationManager()
    private let pathManager = JRPathManager()
    
    //MARK: UI Element Properties
    fileprivate var onBoxLayer: CAShapeLayer?
    fileprivate var checkmarkLayer: CAShapeLayer?
    private var offBoxLayer: CAShapeLayer?
    private var plusLayer: CAShapeLayer?
    
    //MARK: Initialization
    public init() {
        super.init(frame: CGRect.zero)
        self.configureView()
        self.configureAnimationManager()
    }
    
    public init(frame: CGRect, options: [JRCheckmarkButtonOption]?) {
        super.init(frame: frame)
        if let options = options {
            self.configureOptions(options: options)
        }
        self.configureView()
        self.configureAnimationManager()
    }
    
    public convenience init(options: [JRCheckmarkButtonOption]?) {
        self.init(frame: CGRect.zero, options: options)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.setButtonChecked(checked: false, animated: false)
    }
    
    override func layoutSubviews() {
        self.pathManager.size = self.frame.size.height
        super.layoutSubviews()
    }
    
    //MARK: Configuration
    fileprivate func configureOptions(options: [JRCheckmarkButtonOption]) {
        for option in options {
            switch (option) {
                case let .lineWidth(value):
                    self.lineWidth = value
                case let .animationDuration(value):
                    self.animationDuration = value
                case let .checkedTintColor(value):
                    self.checkedTintColor = value
                case let .checkedFillColor(value):
                    self.checkedFillColor = value
                case let .checkedCheckColor(value):
                    self.checkedCheckColor = value
                case let .uncheckedTintColor(value):
                    self.uncheckedTintColor = value
            }
        }
    }
    
    fileprivate func configureView() {
        self.backgroundColor = UIColor.clear
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:))))
    }
    
    fileprivate func configureAnimationManager() {
        self.animationManager.animationDuration = self.animationDuration
    }
    
    //MARK: Button Management
    func setButtonChecked(checked: Bool, animated: Bool) {
        self.checked = checked
        self.drawEntireCheckbox()
        
        if checked == true {
            if animated == true {
                self.addCheckedAnimation()
            }
        } else {
            if animated == true {
                self.addUncheckedAnimation()
            } else {
                self.onBoxLayer?.removeFromSuperlayer()
                self.checkmarkLayer?.removeFromSuperlayer()
            }
        }
    }
    
    fileprivate func drawEntireCheckbox() {
        if self.offBoxLayer == nil || self.offBoxLayer!.path!.boundingBox.size.height == 0.0 {
            self.drawOffButton()
            self.drawPlus()
        }
        
        if self.checked {
            self.drawOnButton()
            self.drawCheckmark()
        }
    }
    
    //MARK: Drawers
    fileprivate func drawOnButton() {
        self.onBoxLayer?.removeFromSuperlayer()
        self.onBoxLayer = CAShapeLayer()
        self.onBoxLayer!.frame = self.bounds
        self.onBoxLayer!.path = self.pathManager.pathForButtonFrame().cgPath
        self.onBoxLayer!.lineWidth = self.lineWidth
        self.onBoxLayer!.fillColor = self.checkedFillColor.cgColor
        self.onBoxLayer!.strokeColor = self.checkedTintColor.cgColor
        self.onBoxLayer!.rasterizationScale = 2.0 * UIScreen.main.scale
        self.onBoxLayer!.shouldRasterize = true
        self.layer.addSublayer(self.onBoxLayer!)
    }
    
    fileprivate func drawOffButton() {
        self.offBoxLayer?.removeFromSuperlayer()
        self.offBoxLayer = CAShapeLayer()
        self.offBoxLayer!.frame = self.bounds
        self.offBoxLayer!.path = self.pathManager.pathForButtonFrame().cgPath
        self.offBoxLayer!.fillColor = UIColor.clear.cgColor
        self.offBoxLayer!.strokeColor = self.uncheckedTintColor.cgColor
        self.offBoxLayer!.lineWidth = self.lineWidth
        
        self.offBoxLayer!.rasterizationScale = 2.0 * UIScreen.main.scale
        self.offBoxLayer!.shouldRasterize = true
        
        self.layer.addSublayer(self.offBoxLayer!)
    }
    
    fileprivate func drawPlus() {
        self.plusLayer?.removeFromSuperlayer()
        self.plusLayer = CAShapeLayer()
        self.plusLayer!.frame = self.bounds
        self.plusLayer!.path = self.pathManager.pathForPlus().cgPath
        self.plusLayer!.fillColor = UIColor.clear.cgColor
        self.plusLayer!.strokeColor = self.uncheckedTintColor.cgColor
        self.plusLayer!.lineWidth = self.lineWidth
        self.plusLayer!.lineCap = kCALineCapRound
        self.plusLayer!.lineJoin = kCALineJoinRound
        
        self.plusLayer!.rasterizationScale = 2.0 * UIScreen.main.scale
        self.plusLayer!.shouldRasterize = true
        self.layer.addSublayer(self.plusLayer!)
    }
    
    fileprivate func drawCheckmark() {
        self.checkmarkLayer?.removeFromSuperlayer()
        self.checkmarkLayer = CAShapeLayer()
        self.checkmarkLayer!.frame = self.bounds
        self.checkmarkLayer!.path = self.pathManager.pathForCheckmark().cgPath
        self.checkmarkLayer!.strokeColor = self.checkedCheckColor.cgColor
        self.checkmarkLayer!.lineWidth = self.lineWidth
        self.checkmarkLayer!.fillColor = UIColor.clear.cgColor
        self.checkmarkLayer!.lineCap = kCALineCapRound
        self.checkmarkLayer!.lineJoin = kCALineJoinRound
        
        self.checkmarkLayer!.rasterizationScale = 2.0 * UIScreen.main.scale
        self.checkmarkLayer!.shouldRasterize = true
        self.layer.addSublayer(self.checkmarkLayer!)
    }
    
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        self.setButtonChecked(checked: !self.checked, animated: true)
        self.sendActions(for: .touchUpInside)
    }
    
    fileprivate func addCheckedAnimation() {
        let wiggle = self.animationManager.fillAnimationWithBounces(2, amplitude: 0.35, reverse: false)
        wiggle.delegate = self
        
        let opacityAnimation = self.animationManager.opacityAnimationReverse(false)
        opacityAnimation.duration = Double(self.animationDuration / 1.4)
        
        self.onBoxLayer!.add(opacityAnimation, forKey: "opacity")
        self.checkmarkLayer!.add(wiggle, forKey: "transform")
    }
    
    fileprivate func addUncheckedAnimation() {
        let wiggle = self.animationManager.fillAnimationWithBounces(1, amplitude: 0.35, reverse: true)
        wiggle.duration = Double(self.animationDuration / 1.1)
        let opacity = self.animationManager.opacityAnimationReverse(true)
        opacity.delegate = self
        
        self.onBoxLayer!.add(opacity, forKey: "opacity")
        self.checkmarkLayer!.add(wiggle, forKey: "transform")
    }
}

extension JRCheckmarkButton: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (self.checked == false) {
            self.onBoxLayer!.removeFromSuperlayer()
            self.checkmarkLayer!.removeFromSuperlayer()
        }
    }
}
