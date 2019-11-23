//
//  AppImage+ UIImage.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 23/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UIImage {
    
    // MARK: - Public Methods
    
    public func base64String() -> String? {
        let data = pngData()
        return data?.base64EncodedString()
    }
    
}
