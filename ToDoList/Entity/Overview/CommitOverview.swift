//
//  CommitOverview.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/21.
//

import Foundation

struct Commit: Codable, Identifiable {
    var id = UUID()
    var date: Date
    var level: Int
    var count: Int
    
    init(date: Date, level: Int, count: Int) {
        self.date = date
        self.level = level
        self.count = count
    }
}

//struct CommitHistory: Identifiable {
//    var id = UUID()
//    var today: Int
//    var thisYear: Int
//    var continuous: Int
//    init(today: Int, thisYear: Int, continuous: Int) {
//        self.today = today
//        self.thisYear = thisYear
//        self.continuous = continuous
//    }
//}

struct ProfileImage: Decodable {
    var image: Data
}
