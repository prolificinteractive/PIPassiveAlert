//
//  ViewController.swift
//  PIPassiveAlertExample-Swift
//
//  Created by Harlan Kellaway on 2/28/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import PIPassiveAlert
import UIKit

class ViewController: UIViewController, PIPassiveAlertDelegate {
    
    private var alertCount: Int = 0

    // MARK: - Protocol conformance
    
    // MARK: PIPassiveAlertDelegate
    
    func passiveAlertDidReceiveTap(passiveAlert: PIPassiveAlert) {
        alertCount = alertCount + 1
        
        PIPassiveAlertDisplayer.showMessage(message(), inViewController: self, showType: .Bottom, shouldAutoHide: true, delegate: self)
    }
    
    func passiveAlertConfig() -> PIPassiveAlertConfig! {
        let config = PIPassiveAlertConfig()
        
        config.autoHideDelay = 1.0
        config.height = 70.0
        config.backgroundColor = passiveAlertBackgroundColor()
        config.font = UIFont.systemFontOfSize(22.0)
        
        return config
    }
    
    // MARK: - Instance functions
    
    // MARK: Private functions
    
    @IBAction private func didTapButton(sender: AnyObject) {
        alertCount = alertCount + 1
        
        PIPassiveAlertDisplayer.showMessage(message(), inViewController: self, showType: .Top, shouldAutoHide: false, delegate: self)
    }
    
    private func passiveAlertBackgroundColor() -> UIColor! {
        if (alertCount % 2) == 0 {
            return PIPassiveAlertDisplayer.defaultConfig().backgroundColor
        } else {
            return randomColor()
        }
    }
    
    private func message() -> String {
        return "Tap me! Alert #\(alertCount)"
    }
    
    private func randomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

