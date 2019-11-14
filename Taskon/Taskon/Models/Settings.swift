//
//  Settings.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 14/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import UIKit

enum PhotoSize: Int, Codable {
    case vga
    case hd
    case twoK
}

struct Settings: Codable {
    
    // MARK: - Class Propeties
    
    var appInfo: String
    var size: PhotoSize
    var locationCheckInterval: Int
    var locationAccuracy: Int
    var autoSyncInterval: Int
    var autoSync: Bool
    var reminder: Bool
    var reminderInterval: Int
    var reminderReitrationTime: Int
    var gadgetId: String
    
    
    // MARK: - Initialization Methods
    
    init() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1.0"
        appInfo = version + " / " + build
        size = .hd
        locationCheckInterval = 300
        locationAccuracy = 50
        autoSyncInterval = 5
        autoSync = true
        reminder = true
        reminderInterval = 15
        reminderReitrationTime = 10
        gadgetId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
}
