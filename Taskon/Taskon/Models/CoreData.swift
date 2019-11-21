//
//  CoreData.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 19/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct CoreData: Codable {
    
    // MARK: - Class Propeties
    
    let time: Int
    let locations: [Location]
    let taskTypes: [TaskType]
    let taskPauseTypes: [TaskPauseType]
    let taskStopTypes: [TaskPauseType]
    let tasks: [Task]
    let questionnaires: [Questionnaires]
    let questions: [Question]
    let answers: [Answer]
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case time = "data_timestamp"
        case locations = "locations"
        case taskTypes = "task_types"
        case taskPauseTypes = "task_pause_types"
        case taskStopTypes = "task_stop_types"
        case tasks = "tasks"
        case questionnaires = "questionnaires"
        case questions = "questions"
        case answers = "answers"
    }
}
