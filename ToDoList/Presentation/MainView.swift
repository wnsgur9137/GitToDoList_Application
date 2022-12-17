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
            GitHubView()
//            let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
//            if userID == "" {
//                LoginView(reflash: self.$reflash)
//            } else {
//                GitHubView()
//            }
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

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
