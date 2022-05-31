//
//  AppState.swift
//  TodoList
//
//  Created by Mohammad Azam on 5/31/22.
//

import Foundation

class AppState: ObservableObject {
    @Published var taskToUpdate: Task?
    @Published var taskToUpdateId: ObjectIdentifier?
}
