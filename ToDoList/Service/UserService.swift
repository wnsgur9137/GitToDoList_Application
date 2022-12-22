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
    
    @EnvironmentObject var loadingService: LoadingService
    @ObservedObject var loginViewModelAccessToken: LoginViewModel = LoginViewModel()
    
    @Published var commits: [Commit] = []
    @Published var isLogin: Bool = false
    @Published var userInfo: UserInfoOverview = UserInfoOverview(
        userId: "알 수 없어요",
        name: "등록된 이름이 없어요",
        avatarUrl: "",
        company: "",
        type: "User",
        blog: "블로그가 없어요",
        location: "",
        email: "등록된 이메일이 없어요",
        hireable: "",
        bio: "",
        twitterUsername: "연동된 트위터 계정이 없어요",
        publicRepos: 0,
        publicGists: 0,
        followers: 0,
        following: 0,
        plan: Plan(
            plan: "",
            space: 0,
            collaborators: 0,
            privateRepos: 0),
        id: 0,
        url: "",
        htmlUrl: "",
        followersUrl: "",
        followingUrl: "",
        gistsUrl: "",
        subscriptionsUrl: ""
    )
    
    private var userID: String
    private var accessToken: String
    
    func logout() {
        print("userService: LogOut")
        UserDefaults.standard.removeObject(forKey: "userID")
        KeychainSwift().clear()
    }
    
    init() {
        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
//        self.accessToken = KeychainSwift().get("accessToken") ?? "없음"
        self.accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
//        self.getUserInfo()
    }
    
    func getUserInfo() {
        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        self.accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        print("(UserService) userID: \(userID)")
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
                        self?.userInfo = result
                    } catch {
                        print("UserService: getUserInfo JSON Parsing Error")
                    }
                case .failure(let error):
                    print("UserService: getUserInfo JSON Error: \(error)")
                }

            })
    }
    
//    func getCommitData() {
//        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
//        Task{@MainActor in
//            do {
////                let className = ".js-calendar-graph mx-md-2 mx-3 d-flex flex-column flex-items-end flex-xl-items-center overflow-hidden pt-1 is-graph-loading graph-canvas ContributionCalendar height-full text-center"
//
//                //            let html = try String(contentsOf: url, encoding: .utf8)
//                let doc: Document = try SwiftSoup.parse(html)
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "YYYY-MM-dd"
//                let today = dateFormatter.string(from: Date())
//                print("today: \(today)")
//                let commitData: Elements = try doc.select(".f4 text-normal mb-2")
//                print(try commitData.text())
//
//            } catch let error {
//                print("getCommitData Error: \(error)")
//            }
//
//            let urlAddress = "https://github.com/users/\(self.userID)/contributions"
//            guard let url = URL(string: urlAddress) else { return }
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
}
    
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

