//
//  Questionnaires.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 21/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct Questionnaires: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let title: String
    let uniqueCode: String
    let isDeleted: Int
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case uniqueCode = "unique_code"
        case isDeleted = "is_deleted"
    }
}


// MARK: - Questions

struct Question: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let title: String
    let uniqueCode: String
    let questionnaireId: Int
    let seq: String
    let options: Int
    let isDeleted: Int
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case uniqueCode = "unique_code"
        case questionnaireId = "questionnaire_id"
        case seq = "seq"
        case options = "options"
        case isDeleted = "is_deleted"
    }
}


// MARK: - Answers

struct Answer: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let title: String
    let uniqueCode: String
    let questionId: Int
    let seq: String
    let isDeleted: Int
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case uniqueCode = "unique_code"
        case questionId = "question_id"
        case seq = "seq"
        case isDeleted = "is_deleted"
    }
}


