//
//  CommitOverview.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/21.
//

import Foundation

// Commit Data
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

struct ProfileImage: Decodable {
    var image: Data
}
