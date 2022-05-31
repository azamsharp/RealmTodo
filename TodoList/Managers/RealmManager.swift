//
//  RealmManager.swift
//  TodoList
//
//  Created by Mohammad Azam on 5/30/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    let app: App
    @Published var realm: Realm
    
    static let shared = RealmManager()
    var notificationToken: NotificationToken?
    @Published var tasks: Results<Task>?
    
    var tasksArray: [Task] {
        if let tasks = tasks {
            return Array(tasks)
        } else {
            return [] 
        }
    }
    
    private init() {
        self.app = App(id: "application-0-stjkl")
        self.realm = try! Realm() 
        authenticate()
    }
    
    private func setupObservers() {
        let observableTasks = realm.objects(Task.self)
        notificationToken = observableTasks.observe { [weak self] _ in
            DispatchQueue.main.async {
                print(observableTasks)
                self?.tasks = observableTasks
            }
        }
    }
    
    
    private func authenticate() {
        
        app.login(credentials: Credentials.anonymous) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(_):
                        self.configureRealm()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
        
    }
    
    private func configureRealm() {
        
        guard let user = app.currentUser else { return }
        // The partition determines which subset of data to access.
        let partitionValue = "_partition"
        // Get a sync configuration from the user object.
        let configuration = user.configuration(partitionValue: partitionValue)
        // Open the realm asynchronously to ensure backend data is downloaded first.
        Realm.asyncOpen(configuration: configuration) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
            case .success(let realm):
                    self?.realm = realm
                    self?.setupObservers()
            }
        }
        
    }
    
}
