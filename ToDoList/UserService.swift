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
import KeychainSwift

class UserService: ObservableObject {
    
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    @Published var isLogin: Bool = false
    
    private let userID: String
    private let baseURL: String
    
    func logout() {
        print("userService: LogOut")
        UserDefaults.standard.removeObject(forKey: "userID")
        KeychainSwift().clear()
    }
    
    init() {
        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        self.baseURL = "http://github.com/users/\(userID)/contributions"
    }
    
}
    
//    @Published var commits: [Commit] = []
//
//    private let userID: String
//    private let baseURL: String
//
//    var hasCommitted: Int = emoji.notCommitted.rawValue
//
//    init() {
////        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
//        self.userID = "wnsgur9137"
//        self.baseURL = "http://github.com/users/\(userID)/contributions"
//        getCommitData()
//    }
//
//    func getCommitData() {
//        guard let url: URL = URL(string: baseURL) else { fatalError("Cannot Get URL") }
//        if self.userID != "" {
//            do {
//                let html = try String(contentsOf: url, encoding: .utf8)
//                let parsedHtml = try SwiftSoup.parse(html)
//                let dailyContribution = try parsedHtml.select("rect")
//
//                commits = dailyContribution
//                    .compactMap({ element -> (String, String) in
//                        guard
//                            let dateString = try? element.attr("data-date"),
//                            let levelString = try? element.attr("data-level")
//                        else { return ("", "") }
//
//                        return (dateString, levelString)
//                    })
//                    .filter{ $0.0.isEmpty == false }
//                    .compactMap({ (dateString, levelString) -> Commit in
//                        let date = dateString.toDate() ?? Date()
//                        let level = Int(levelString) ?? 0
//
//                        return Commit(date: date, level: level)
//                    })
//
//                if commits.last!.date.isToday && commits.last!.level > 0 {
//                    self.hasCommitted = emoji.committed.rawValue
//                }
//            }
//            catch {
//                fatalError("Cannot Get Data: \(error.localizedDescription)")
//            }
//        }
//    }

