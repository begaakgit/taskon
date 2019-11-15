//
//  AppButton.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 15/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    // MARK: - Class Properties
    
    var enable: Bool {
        set {
            isEnabled = newValue
            backgroundColor = newValue ? .mainBlue : .darkGray
        }
        get {
            return isEnabled
        }
    }
    
}
