//
//  AppTableView+UITableView.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(types: Registerable.Type ...) {
        for type in types {
            print("type: \(type), identifier: \(type.identifier)")
            register(type.getNIB(), forCellReuseIdentifier: type.identifier)
        }
    }
    
    func getCell<T: Registerable>(type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func setEmpty(text: String) {
        let emptyLabel = UILabel(frame: frame)
        emptyLabel.text = text
        emptyLabel.textAlignment = .center
        emptyLabel.font = UIFont.systemFont(ofSize: 20.0)
        emptyLabel.textColor = .darkGray
        emptyLabel.numberOfLines = 0
        emptyLabel.sizeToFit()
        emptyLabel.isEnabled = false
        backgroundView = emptyLabel
    }
    
    func resetEmptyText() {
        backgroundView = UIView(frame: .zero)
    }
    
}
