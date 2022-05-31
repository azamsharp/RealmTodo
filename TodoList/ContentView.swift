//
//  ContentView.swift
//  TodoList
//
//  Created by Mohammad Azam on 5/25/22.
//

import SwiftUI
import RealmSwift
import Combine



struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var taskName: String = ""
    @State private var priority: Priority = .medium
    @State var cancellable: AnyCancellable?
    
    @StateObject var realmManager: RealmManager
    
    private func save(_ task: Task) {
        do {
            
            let realm = realmManager.realm
            
            try realm.write {
                realm.add(task)
            }
            
        } catch {
            print(error)
        }
        
        taskName = ""
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Enter task", text: $taskName)
                    .textFieldStyle(.roundedBorder)
                
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.title)
                    }
                }.pickerStyle(.segmented)
                
                Button {
                    // action
                    let task = Task()
                    task.title = taskName
                    task.priority = priority
                    
                    save(task)
                    
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                
                if let tasks = realmManager.tasksArray {
                    let _ = print("INSIDE IF")
                    let _ = print(tasks.count)
                    TodoListView(tasks: tasks)
                }
                   
                    
                
            }.onAppear {
                setupSubscriptions()
            }
            
            Spacer()
            
        }.padding()
            .navigationTitle("Tasks")
    }
    
    private func update(_ task: Task) {
        
        do {
            try realmManager.realm.write {
                task.isCompleted.toggle()
            }} catch {
                print(error)
        }
    }
    
    private func setupSubscriptions() {
        
        self.cancellable = appState.$taskToUpdate.sink { task in
            guard let task = task else { return }
            update(task)
        }
    }
}



