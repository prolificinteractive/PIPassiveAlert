//
//  ViewController.swift
//  PIPassiveAlertExample-Swift
//
//  Created by Harlan Kellaway on 2/28/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import PIPassiveAlert
import UIKit

class ViewController: UIViewController, PassiveAlertDelegate {
    
    private var alertCount: Int = 0

    // MARK: - Protocol conformance
    
    // MARK: PIPassiveAlertDelegate
    
    func passiveAlertDidReceiveTap(passiveAlert: PassiveAlert) {
        alertCount = alertCount + 1
        
        PassiveAlert.showMessage(message(), inViewController: self, showType: .Bottom, shouldAutoHide: true, delegate: self)
    }
    
    func passiveAlertAutoHideDelay() -> CGFloat {
        return 0.5
    }
    
    func passiveAlertBackgroundColor() -> UIColor! {
        if (alertCount % 2) == 0 {
            return PassiveAlert.defaultBackgroundColor()
        } else {
            return randomColor()
        }
    }
    
    func passiveAlertFont() -> UIFont! {
        return UIFont.systemFontOfSize(22.0)
    }
    
    // MARK: - Instance functions
    
    // MARK: Private functions
    
    @IBAction private func didTapButton(sender: AnyObject) {
        alertCount = alertCount + 1
        
        PassiveAlert.showMessage(message(), inViewController: self, showType: .Top, shouldAutoHide: false, delegate: self)
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

