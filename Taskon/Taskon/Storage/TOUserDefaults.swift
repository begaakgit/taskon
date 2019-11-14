//
//  TOUserDefaults.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation


struct TOUserDefaults {
    static var client = UserDefaultObject<TOClient>(key: "Client")
    static var user = UserDefaultObject<User>(key: "User")
    static var settings = UserDefaultObject<Settings>(key: "Settings")
    
    static func clearDefaults() {
        client.clear()
        user.clear()
        settings.clear()
    }
}

struct UserDefaultObject<T> {
    
    // MARK: - Class Propeties
    
    private var key: String
    private var value: T?
    
    
    // MARK: - Initialization Methods
    
    init(key k: String) {
        key = k
    }
    
    
    // MARK: - Public Methods
    
    public mutating func clear() {
        value = nil
        UserDefaults.standard.removeObject(forKey: key)
    }
}


// MARK: - Codable Methods

extension UserDefaultObject where T: Codable {
    mutating func get() -> T? {
        if value == nil {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: key),
                let val = try? decoder.decode(T.self, from: data) {
                value = val
            }
        }
        return value
    }
    
    mutating func set(value val: T) {
        value = val
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}


// MARK: - String Methods

extension UserDefaultObject where T == String {
    
    mutating func get() -> T? {
        if value == nil {
            value =  UserDefaults.standard.string(forKey: key)
        }
        return value
    }
    
    mutating func set(value val: T) {
        value = val
        UserDefaults.standard.set(value, forKey: key)
    }
    
}


// MARK: - Int Methods

extension UserDefaultObject where T == Int {
    mutating func get() -> T? {
        if value == nil {
            value =  UserDefaults.standard.integer(forKey: key)
        }
        return value
    }
    
    mutating func set(value val: T) {
        value = val
        UserDefaults.standard.set(value, forKey: key)
    }
}


// MARK: - Double Methods

extension UserDefaultObject where T == Double {
    mutating func get() -> T? {
        if value == nil {
            value =  UserDefaults.standard.double(forKey: key)
        }
        return value
    }
    
    mutating func set(value val: T) {
        value = val
        UserDefaults.standard.set(value, forKey: key)
    }
    
}


// MARK: - Bool Methods

extension UserDefaultObject where T == Bool {
    
    mutating func set(value val: T) {
        value = val
        UserDefaults.standard.set(value, forKey: key)
    }
    
    mutating func get() -> T {
        if value == nil {
            value =  UserDefaults.standard.bool(forKey: key)
        }
        return value ?? false
    }

}


// MARK: - Date Methods

extension UserDefaultObject where T == Date {
   
    mutating func get() -> T? {
        
        if value == nil {
            var doubleValue = UserDefaultObject<Double>(key: key)
            if let timeInterval = doubleValue.get() {
                if timeInterval != 0 {
                    value = Date(timeIntervalSince1970: timeInterval)
                }
            }
        }
        return value
    }
    
    mutating func set(value val: T) {
        value = val
        UserDefaults.standard.set(value!.timeIntervalSince1970, forKey: key)
    }
}


// MARK: - Array Of String Methods

extension UserDefaultObject where T == [String] {
    
    mutating func get() -> T? {
        if value == nil {
            if let array = UserDefaults.standard.array(forKey: key) as? [String] {
                debugPrint("Array: \(array)")
                value = array
            }
        }
        return value
    }
    
    mutating func append(value: String) {
        var array: [String] = []
        if let tempArray = get() {
            array.append(contentsOf: tempArray)
        }
        array.append(value)
        UserDefaults.standard.set(array, forKey: key)
    }
    
}
