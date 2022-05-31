//
//  TodoListView.swift
//  TodoList
//
//  Created by Mohammad Azam on 5/31/22.
//

import SwiftUI
import RealmSwift

enum Sections: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct TodoListView: View {
    
    let tasks: [Task]
   
    var pendingTasks: [Task] {
       // tasks.where { $0.isCompleted == false }
        tasks.filter { !$0.isCompleted }
    }
    
    var completedTasks: [Task] {
       // tasks.where { $0.isCompleted == true }
        tasks.filter { $0.isCompleted }
    }
    
    var body: some View {
        let _ = print(Self._printChanges())
        List {
            ForEach(Sections.allCases, id: \.self) { section in
                Section {
                    ForEach(section == .pending ? pendingTasks: completedTasks, id: \._id) { task in
                        TaskCellView(task: task) 
                    }
                } header: {
                    Text(section.rawValue)
                }
            }
        }.listStyle(.plain)
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        let realm = try! Realm()
        TodoListView(tasks: [])
    }
}
