//
//  StaticData.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 25/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct StaticData: Codable {
    
    // MARK: - Class Propeties
    
    let timestamp: Int
    let users: [StaticUser]
    let objects: [StaticObject]
    let checklist: [TemplateCheckList]
    let report: [TemplateTaskReport]
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "data_timestamp"
        case users = "users"
        case objects = "objects"
        case checklist = "template_checklist"
        case report = "template_taskreport"
    }
}


// MARK: - Static User

struct StaticUser: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let name: String
    let surname: String
    let isDeleted: Int
    
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case surname = "surname"
        case isDeleted = "is_deleted"
    }
}


// MARK: - Static Objects

struct StaticObject: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let title: String
    let type: String?
    let latitude: String
    let longitude: String
    let isDeleted: Int
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case type = "type"
        case latitude = "latitude"
        case longitude = "longitude"
        case isDeleted = "is_deleted"
    }
}


// MARK: - Templete Checklist

struct TemplateCheckList: Codable {
    
    // MARK: - Class Propeties
    
    let checkListBase64: String
    let qualityLevels: [TemplateCheckListQualityLevel]
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case checkListBase64 = "template_checklist_base64"
        case qualityLevels = "template_checklist_quality_levels"
    }
}


// MARK: - Template CheckList Quality Level

struct TemplateCheckListQualityLevel: Codable {
    
    // MARK: - Class Propeties
    
    let code: String
    let value: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case code = "unique_code"
        case value = "value"
    }
}


// MARK: - Template Task Report

struct TemplateTaskReport: Codable {
    
    // MARK: - Class Propeties
    
    let taskReportBase64: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case taskReportBase64 = "template_taskreport_base64"
    }
}
