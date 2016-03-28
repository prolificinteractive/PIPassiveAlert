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
    
    func passiveAlertDidReceiveTap(passiveAlert: PIPassiveAlert, atPoint: CGPoint) {
        alertCount = alertCount + 1
        
        PIPassiveAlertDisplayer.displayMessage(message("Random!"), inViewController: self, originYCalculation: randomOriginYCalculation(), shouldAutoHide: false, delegate: self)
    }
    
    func configurePassiveAlert(config: PIPassiveAlertConfig) {
        config.autoHideDelay = 1.0
        config.backgroundColor = passiveAlertBackgroundColor()
        config.font = UIFont.systemFontOfSize(22.0)
    }
    
    // MARK: - Instance functions
    
    // MARK: Private functions
    
    @IBAction private func didTapButton(sender: AnyObject) {
        alertCount = alertCount + 1
        
        let side: PIPassiveAlertConstraintSide = ((alertCount % 2) == 0) ? .Bottom : .Top
        
        PIPassiveAlertDisplayer.displayMessage(message("Tap me!"), inViewController: self, side: side, shouldAutoHide: true, delegate: self)
    }
    
    private func randomOriginYCalculation() -> PIPassiveAlertOriginYCalculation {
        return {
            (alertConfig, containingViewSize) in
            
            let randomNumber = self.getRandomNumber(between: 0, and: UInt32(containingViewSize.height))
            let max = containingViewSize.height - alertConfig.height
            
            if randomNumber > max {
                return max
            }
            
            return randomNumber
        }
    }
    
    private func passiveAlertBackgroundColor() -> UIColor! {
        if (alertCount % 2) == 0 {
            return PIPassiveAlertDisplayer.defaultConfig().backgroundColor
        } else {
            return randomColor()
        }
    }
    
    private func message(stub: String) -> String {
        return "\(stub) Alert #\(alertCount)"
    }
    
    private func getRandomNumber(between lower: UInt32, and upper: UInt32) -> CGFloat {
        return CGFloat(lower + arc4random() % (upper - lower))
    }
    
    private func randomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

