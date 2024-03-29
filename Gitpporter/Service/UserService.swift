//
//  UserService.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/15.
//

import Foundation
import SwiftUI
import SwiftSoup
import KeychainSwift
import Alamofire

class UserService: ObservableObject {
    
    @EnvironmentObject var loadingService: LoadingService
    @ObservedObject var loginViewModelAccessToken: LoginViewModel = LoginViewModel()
    
    @Published var commits: [Commit] = []   // Commit 데이터
    @Published var isCommited: Bool = false // 커밋을 했는지 확인하는 여부
    @Published var commitHistory: [String:Int] = ["today": 0,   // 오늘 커밋
                                                  "thisYear": 0,    // 일년간 커밋
                                                  "continuous": 0]  // 연속 커밋
    
    @Published var isLogin: Bool = false    // 로그인 상태 확인 여부
    @Published var userInfo: UserInfoOverview = UserInfoOverview(   // 유저 정보
        userId: "알 수 없어요".localized(),
        name: "등록된 이름이 없어요".localized(),
        avatarUrl: "",
        company: "",
        type: "User",
        blog: "블로그가 없어요".localized(),
        location: "",
        email: "등록된 이메일이 없어요".localized(),
        hireable: "",
        bio: "",
        twitterUsername: "연동된 트위터 계정이 없어요".localized(),
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
    
    private var userID: String  // 유저 아이디
    private var accessToken: String // GitHub API 이용하기 위한 토큰
    
    /// 로그아웃 함수.
    func logout() {
        print("userService: LogOut")
        UserDefaults.standard.removeObject(forKey: "userID")
        KeychainSwift().clear()
    }
    
    /// 초기화
    init() {
        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        self.accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    /// 유저 정보를 받아온다.
    func getUserInfo() {
        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        self.accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        print("(UserService) userID: \(userID)")
        let url = "https://api.github.com/user"
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.github.v3+json",
            "Authorization": "token \(accessToken)"
        ]
        AF.request(url, method: .get, parameters: [:], headers: headers)
            .response(completionHandler: { [weak self] (response) in
                switch response.result {
                case .success(let json):
                    do {
                        let result = try JSONDecoder().decode(UserInfoOverview.self, from: json!)
                        self?.userInfo = result
                        print(result)
                    } catch {
                        print("UserService.doCatch: getUserInfo JSON Parsing Error")
                    }
                case .failure(let error):
                    print("UserService.failure: getUserInfo JSON Error: \(error)")
                }

            })
    }
    
    /// 커밋 데이터를 가져온다.
    func getCommitData() {
        self.userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        Task{@MainActor in
            let urlAddress = "https://github.com/users/\(self.userID)/contributions"
            guard let url = URL(string: urlAddress) else { return }
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let parsedHtml = try SwiftSoup.parse(html)
                let dailyContribution = try parsedHtml.select("rect")
                let thisYearContribution = try parsedHtml.getElementsByClass("f4 text-normal mb-2").text().split(separator: " ")[0]

                commits = dailyContribution
                    .compactMap({ element -> (String, String, String) in
                        guard
                            let dateString = try? element.attr("data-date"),
                            let levelString = try? element.attr("data-level"),
                            let countString = try? element.attr("data-count")
                        else { return ("", "", "") }
                        
                        return (dateString, levelString, countString)
                    })
                    .filter{ $0.0.isEmpty == false }
                    .compactMap({ (dateString, levelString, countString) -> Commit in
                        let date = dateString.toDate() ?? Date()
                        let level = Int(levelString) ?? 0
                        let count = Int(countString) ?? 0
                        return Commit(date: date, level: level, count: count)
                    })

                if commits.last!.date.isToday && commits.last!.level > 0 {
                    self.isCommited = true
                } else {
                    self.isCommited = false
                }
                
                /// Commit History
                self.commitHistory["today"] = commits.last!.count
                self.commitHistory["thisYear"] = Int(thisYearContribution) ?? 0
                
                /// Notification을 사용하기 위한 UserDefaults
                if commits.last!.count > 0 {
                    UserDefaults.standard.set(true, forKey: "commitDataBool")
                } else {
                    UserDefaults.standard.set(false, forKey: "commitDataBool")
                }
                
                var commitsCount = self.commits.count
                var commitContinues = 0
                repeat {
                    commitsCount -= 1
                    if self.commits[commitsCount].level == 0 {
                        break
                    } else {
                        commitContinues += 1
                    }
                } while true
                self.commitHistory["continues"] = Int(commitContinues)
            }
            catch {
                print("Cannot Get Data: \(error.localizedDescription)")
            }
        }
    }
}
