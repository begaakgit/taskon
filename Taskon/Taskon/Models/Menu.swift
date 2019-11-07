//
//  Menu.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

enum MenuItem: Int, CaseIterable {
    case newTask
    case syncData
    case filterByDistance
    case filterByDeadline
    case filterByDate
    case settings
    case logout
}

enum Filter: Int, CaseIterable {
    case distance
    case deadLine
    case date
}
