//
//  AppViewController+UIViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func instanceFromStoryboard<T: UIViewController>(storyboard: UIStoryboard) -> T {
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        return viewController
    }
    
}
