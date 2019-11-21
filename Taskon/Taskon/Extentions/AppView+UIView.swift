//
//  AppView+UIView.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Class Properties
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: CGColor? {
        get {
            return layer.borderColor
        }
        set {
            layer.borderColor = newValue
        }
    }
}
