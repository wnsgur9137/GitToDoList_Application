//
//  LoginViewModel.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/16.
//

import Foundation
import Combine
import SwiftUI
import Alamofire
import KeychainSwift

class LoginViewModel: ObservableObject {
    
    @Published var accessToken: String = ""
    @EnvironmentObject var userService: UserService
    
    let clientID = GitHub.clientID
    let secret = GitHub.secrets
    
    func login() -> URL {
        KeychainSwift().clear()
        print("LoginButton Tapped")
        
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize"
        
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: self.clientID),
            URLQueryItem(name: "scope", value: scope),
        ]
        return components.url!
    }
    
    func requestAccessToken(with code: String) {
        let url = "https://github.com/login/oauth/access_token"
        
        let parameters = [
            "client_id": self.clientID,
            "client_secret": self.secret,
            "code": code
        ]
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .response(completionHandler: { [weak self] (response) in
                switch response.result {
                case .success(let json):
                    do {
                        let result = try JSONDecoder().decode(UserTokenOverview.self, from: json!)
                        let accessToken = result.accessToken
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                        self?.accessToken = accessToken
                        UserDefaults.standard.set(accessToken, forKey: "userID")
                        KeychainSwift().set(accessToken, forKey: "accessToken")
                        
                        
                        let url = "https://api.github.com/user"
                        let headers: HTTPHeaders = [
                            "Accept": "application/vnd.github.v3+json",
                            "Authorization": "token \(accessToken)"
                        ]
                        AF.request(url, method: .get, parameters: [:], headers: headers)
                            .response(completionHandler: { (response) in
                                switch response.result {
                                case .success(let json):
                                    do {
                                        let result = try JSONDecoder().decode(UserInfoOverview.self, from: json!)
                                        UserDefaults.standard.set(result.userId, forKey: "userID")
                                    } catch {
                                        print("getUserInfo JSON Parsing Error")
                                    }
                                case .failure(let error):
                                    print("getUserInfo JSON Error: \(error)")
                                }

                            })
                        
                    } catch {
                        print("requestAccessToken Error:")
                    }
                case .failure(let error):
                    print("requestAccessToken Error: \(error)")
                }
            })
    }
}
