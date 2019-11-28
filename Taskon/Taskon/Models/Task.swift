//
//  Task.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 18/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import UIKit

struct Task: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let title: String
    let nr: String
    let status: TaskStatus
    let locationID: Int
    let taskTypeID: Int
    let questionnaireID: Int
    let questionnaireOptions: Int
    let taskPauseID: Int
    let description: String
    let dueTimestamp: String
    let taskStopID: Int
    let abonnent: String
    let subAbon: String
    let customerName: String
    let concerningName: String
    let customerNamePrint: String
    let customerAddress: String
    let contract: String
    let transNr: String
    let instID: String
    let cType: String
    let entryroad: String
    let coderemote: String
    let transloc: String
    let codeno: String
    let adm: String
    let prContact: String
    let prContactPhone: String
    let region: String
    let dangerous: Int
    let isDeleted: Int
    let contacts: [Contact]?
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case nr = "nr"
        case status = "status"
        case locationID = "location_id"
        case taskTypeID = "task_type_id"
        case questionnaireID = "questionnaire_id"
        case questionnaireOptions = "questionnaire_options"
        case taskPauseID = "task_pause_id"
        case description = "description"
        case dueTimestamp = "due_timestamp"
        case taskStopID = "task_stop_id"
        case abonnent = "abonnent"
        case subAbon = "sub_abon"
        case customerName = "customer_name"
        case concerningName = "concerning_name"
        case customerNamePrint = "customer_name_print"
        case customerAddress = "customer_address"
        case contract = "contract"
        case transNr = "trans_nr"
        case instID = "inst_id"
        case cType = "c_type"
        case entryroad = "entryroad"
        case coderemote = "coderemote"
        case transloc = "transloc"
        case codeno = "codeno"
        case adm = "adm"
        case prContact = "pr_contact"
        case prContactPhone = "pr_contact_phone"
        case region = "region"
        case dangerous = "dangerous"
        case isDeleted = "is_deleted"
        case contacts = "contacts"
    }
    
    
    // MARK: - Public Methods
    
    public func search(text: String) -> Bool {
        let searchText = text.lowercased()
        return customerNamePrint.lowercased().contains(searchText)
            || title.lowercased().contains(searchText)
            || dueTimestamp.lowercased().contains(searchText)
            || nr.lowercased().contains(searchText)
            || description.lowercased().contains(searchText)
            || status.getText().lowercased().contains(searchText)
    }
    
    public func search(date: Date) -> Bool {
        guard let taskDate = dueTimestamp.toDate(format: .short) else { return false }
        return Calendar.current.isDate(date, inSameDayAs: taskDate)
    }
    
    public func distance(with locations: [Location]) -> Int {
        if let location = locations.first(where: { $0.id == locationID }) {
            return LocationManager.default.distance(from: location) ?? 0
        }
        
        return 0
    }
}


// MARK: - Task Status

enum TaskStatus: String, Codable {
    case open = "Open"
    case complete = "Complete"
    case registered = "Registered"
    case onHold = "On Hold"
    case inProgress = "In Progress"
    case accepted = "Accepted"
    case approved = "Approved"
    case notFinished = "Not Finished"
    
    func getText() -> String {
        switch self {
        case .open: return "Open"
        case .complete: return "Complete"
        case .registered: return "Registered"
        case .onHold: return "On Hold"
        case .inProgress: return "In Progress"
        case .accepted: return "Accepted"
        case .notFinished: return "Not Finished"
        case .approved: return "Approved"
        }
    }
}


// MARK: - Task Images

struct TaskImage: Codable {
    
    
    // MARK: - Class Propeties
    
    var image: String
    var address: String
    var taskId: Int
    
}
