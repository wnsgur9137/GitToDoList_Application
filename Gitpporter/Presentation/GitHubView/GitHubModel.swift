//
//  GitHubModel.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import Foundation

struct GitHubOverview: Decodable {
    let totalContributions: Int
    let weeks: [Weeks]
}

struct Weeks: Decodable {
    let contributionDays: [Days]
}

struct Days: Decodable {
    let contributionCount: Int
    let date: String
}
