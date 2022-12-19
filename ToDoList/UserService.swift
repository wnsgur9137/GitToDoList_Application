//
//  UserService.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/15.
//

import Foundation
import SwiftUI
import SwiftSoup
//import WidgetKit
import KeychainSwift
import Alamofire

class UserService: ObservableObject {
    
    @Published var isLogin: Bool = false
    @Published var userInfo: UserInfoOverview = UserInfoOverview(userId: "", name: "", avatarUrl: "", company: "", type: "", blog: "https://github.com", location: "", email: "", hireable: "", bio: "", twitterUsername: "", publicRepos: 0, publicGists: 0, followers: 0, following: 0, plan: Plan(plan: "", space: 0, collaborators: 0, privateRepos: 0), id: 0, url: "", htmlUrl: "", followersUrl: "", followingUrl: "", gistsUrl: "", subscriptionsUrl: "")
    
    private let userID: String
    private let baseURL: String
    private let accessToken: String
    
    func logout() {
        print("userService: LogOut")
        UserDefaults.standard.removeObject(forKey: "userID")
        KeychainSwift().clear()
    }
    
    init() {
        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        self.baseURL = "http://github.com/users/\(userID)/contributions"
//        self.accessToken = KeychainSwift().get("accessToken") ?? "없음"
        self.accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        self.getUserInfo()
    }
    
    func getUserInfo() {
        let url = "https://api.github.com/user"
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.github.v3+json",
            "Authorization": "token \(accessToken)"
//                            "Authorization": "token \(APIKeys.token)"
        ]
        AF.request(url, method: .get, parameters: [:], headers: headers)
            .response(completionHandler: { [weak self] (response) in
                switch response.result {
                case .success(let json):
                    do {
                        let result = try JSONDecoder().decode(UserInfoOverview.self, from: json!)
                        print("UserInfoJson: \(result)")
                        self?.userInfo = result
                    } catch {
                        print("UserService: getUserInfo JSON Parsing Error")
                    }
                case .failure(let error):
                    print("UserService: getUserInfo JSON Error: \(error)")
                }

            })
//            .responseJSON(completionHandler: { (response) in
//                switch response.result {
//                case .success(let json):
//                    print(json as! [String: Any])
//                case .failure:
//                    print("getUserInfo JSON Error")
//                }
//            })
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

