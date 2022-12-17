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
        
//        var urlString = "https://github.com/login/oauth/authorize"
//        let urlQuery = "?client_id=\(self.clientID)&scope=\(scope)"
//        urlString += urlQuery
//        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
//            // redirect to scene(_:openURLContexts:) if user authorized
//        }
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
            .responseJSON { (response) in
                switch response.result {
                case let .success(json):
                    if let dic = json as? [String: String] {
                        let accessToken = dic["access_token"] ?? ""
                        KeychainSwift().set(accessToken, forKey: "accessToken")
                    }
                case let .failure(error):
                    print("requestAccessToken Error: \(error)")
                }
            }
    }
    
    func logout() {
        KeychainSwift().clear()
    }
}
