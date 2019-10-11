//
//  Extensions.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import Foundation
import UIKit


extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}

extension UIImage {
   func imageWithBorder(width: CGFloat, color: UIColor) -> UIImage? {
       let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
       let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
       imageView.contentMode = .center
       imageView.image = self
       imageView.layer.borderWidth = width
       imageView.layer.borderColor = color.cgColor
       UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
       guard let context = UIGraphicsGetCurrentContext() else { return nil }
       imageView.layer.render(in: context)
       let result = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return result
   }
}
    

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

extension String {
func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.text = self
    label.font = font
    label.sizeToFit()

    return label.frame.height
 }
}
