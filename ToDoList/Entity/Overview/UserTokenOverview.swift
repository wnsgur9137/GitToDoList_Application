//
//  UserTokenOverview.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/17.
//

import Foundation

struct UserTokenOverview: Decodable {
    let scope: String
    let tokenType: String
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case scope
        case tokenType = "token_type"
        case accessToken = "access_token"
    }
}
