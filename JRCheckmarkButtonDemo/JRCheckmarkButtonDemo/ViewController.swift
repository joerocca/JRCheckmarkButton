//
//  ViewController.swift
//  JRCheckmarkButtonDemo
//
//  Created by Joe Rocca on 2/1/17.
//  Copyright © 2017 Joe Rocca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: UI Element Properties
    let checkmarkButton: JRCheckmarkButton = {
        let options: [JRCheckmarkButtonOption] = [.lineWidth(7.0),
                                                  .animationDuration(Double(0.2)),
                                                  .checkedTintColor(UIColor.blue),
                                                  .checkedFillColor(UIColor.blue),
                                                  .checkedCheckColor(UIColor.white),
                                                  .uncheckedTintColor(UIColor.lightGray)]
        let checkmarkButton = JRCheckmarkButton(options: options)
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        return checkmarkButton
    }()
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: View
        self.view.backgroundColor = UIColor.white
        //MARK: Subviews
        self.view.addSubview(self.checkmarkButton)
        //MARK: Constraints
        self.checkmarkButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.checkmarkButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.checkmarkButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.checkmarkButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
