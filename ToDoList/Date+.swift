//
//  Date+.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/16.
//

import Foundation

extension Date {
    var isToday: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let formattedTodayString = dateFormatter.string(from: Date())
        let formattedToday = dateFormatter.date(from: formattedTodayString)
        
        return self == formattedToday
    }
    
    var formatted: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let formattedString = dateFormatter.string(from: self)
        return dateFormatter.date(from: formattedString) ?? self
    }
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formattedString = dateFormatter.string(from: self)
        return formattedString
    }
}
