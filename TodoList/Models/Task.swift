//
//  Task.swift
//  TodoList
//
//  Created by Mohammad Azam on 5/25/22.
//

import Foundation
import RealmSwift

enum Priority: Int, CaseIterable, PersistableEnum {
    case low
    case medium
    case high
}

extension Priority {
    var title: String {
        switch self {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
        }
    }
}

class Task: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var priority = Priority.medium
}
