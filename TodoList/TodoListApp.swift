//
//  TodoListApp.swift
//  TodoList
//
//  Created by Mohammad Azam on 5/25/22.
//

import SwiftUI
import RealmSwift

@main
struct TodoListApp: SwiftUI.App {
    
    var body: some Scene {
        WindowGroup {
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
            ContentView(realmManager: RealmManager.shared).environmentObject(AppState())
        }
    }
}
