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
    
    init(date: Date, level: Int) {
        self.date = date
        self.level = level
    }
}

struct ProfileImage: Decodable {
    var image: Data
}
