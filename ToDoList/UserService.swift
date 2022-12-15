//
//  UserService.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/15.
//

import Foundation
import SwiftUI
import SwiftSoup
import WidgetKit

class UserService: ObservableObject {
    @Published var commits: [Commit] = []
    
    private let userID: String
    private let baseURL: String
    
    var hasCommitted: Int = emoji.notCommitted.rawValue
    
    init() {
        self.userID = UserDefaults.shared.string(forKey: "userID") ?? ""
        self.baseURL = "http://github.com/users/\(userID)/contributions"
        getCommitData()
    }
    
    func getCommitData() {
        guard let url: URL = URL(string: baseURL) else { fatalError("Cannot Get URL") }
        if self.userID != "" {
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let parsedHtml = try SwiftSoup.parse(html)
                let dailyContributoion = try parsedHtml.select("rect")
                
                commits = dailyContribution
                    .compactMap({ element -> (String, String) in
                        guard
                            let dataString = try? element.attr("data-data"),
                            let levelString = try? element.attr("data-level")
                        else { return ("", "") }
                        
                        return (dataString, levelString)
                    })
                    .filter{ $0.0.isEmpty == false }
                    .compactMap({ (dataString, levelString) -> Commit in
                        let date = dataString.toDate() ?? Date()
                        let level = Int(levelString) ?? 0
                        
                        return Commit(date: date, level: level)
                    })
                
                if commits.last!.date.isToday && commits.last!.level > 0 {
                    self.hasCommitted = emoji.commited.rawValue
                }
            }
            catch {
                FatalError("Cannot Get Data: \(error.localizedDescription)")
            }
        }
    }
}
