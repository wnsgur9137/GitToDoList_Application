//
//  MainView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedIndex: Int = 0
//    @ObservedObject var userService: UserService = UserService()
    
    var body: some View {
        CustomTabView(tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
            let type = TabType(rawValue: index) ?? .toDoList
            getTabView(type: type)
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .github:
            let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
            if userID == "" {
                LoginView()
            } else {
                GitHubView()
            }
        case .toDoList:
            CalendarView()
        case .alarm:
            AlarmView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
