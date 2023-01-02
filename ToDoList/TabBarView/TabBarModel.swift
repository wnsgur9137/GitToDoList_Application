//
//  TabBarModel.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import Foundation

struct TabBarModel {
    let image: String
    let selectedImage: String
    let title: String
}

enum TabType: Int, CaseIterable {
    case github = 0
    case toDoList
//    case alarm
    
    var tabItem: TabBarModel {
        switch self {
        case .github:
            return TabBarModel(image: "square.and.arrow.up", selectedImage: "square.and.arrow.up.fill", title: "깃허브".localized())
        case .toDoList:
            return TabBarModel(image: "calendar", selectedImage: "calendar", title: "캘린더".localized())
//        case .alarm:
//            return TabBarModel(image: "alarm", selectedImage: "alarm.fill", title: "알람")
        }
    }
}
