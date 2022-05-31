//
//  TaskCellView.swift
//  TodoList
//
//  Created by Mohammad Azam on 5/31/22.
//

import SwiftUI
import RealmSwift

struct TaskCellView: View {
    
    var task: Task
    @EnvironmentObject var appState: AppState
    let realmManager = RealmManager.shared
    
    var body: some View {
        let _ = print(Self._printChanges())
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.square": "square")
                .onTapGesture {
                    try! realmManager.realm.write {
                        task.isCompleted.toggle()
                    }
                    //appState.taskToUpdate = task
                }
            Text(task.title)
        }
    }
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView(task: Task())
    }
}
