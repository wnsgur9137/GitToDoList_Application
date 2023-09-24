//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

@main
struct GitpporterApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(UserService())
                .environmentObject(LoadingService())
                .environmentObject(NotificationService())
                .environmentObject(EventService())
//                .environmentObject(CalendarModule().eventService)
        }
    }
}
