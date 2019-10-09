//
//  Extensions.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    convenience init(hexString:String) {
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}


extension UIView {
    func rotate360Degrees(_ duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        DispatchQueue.main.async {
            let kAnimationKey = "rotate360Degrees"
            if self.layer.animation(forKey: "rotate360Degrees") == nil {
                let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
                rotateAnimation.fromValue = 0.0
                rotateAnimation.toValue = CGFloat(-Double.pi * 2.0)
                rotateAnimation.duration = duration
                rotateAnimation.repeatCount = Float.infinity
                self.layer.add(rotateAnimation, forKey: kAnimationKey)
            }
        }
    }
    
    func stop360Rotation() {
        DispatchQueue.main.async {
            let kAnimationKey = "rotate360Degrees"
            if let _ = self.layer.animation(forKey: kAnimationKey) {
                self.layer.removeAnimation(forKey: kAnimationKey)
            }
            
        }
        
    }
}
