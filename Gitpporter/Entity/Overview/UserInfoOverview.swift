//
//  UserInfoOverview.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/17.
//

import Foundation

struct UserInfoOverview: Decodable {
    let userId: String
    let name: String
    let avatarUrl: String?
    let company: String?
    let type: String
    let blog: String?
    let location: String?
    let email: String?
    let hireable: String?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let plan: Plan
    
    let id: Int
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let subscriptionsUrl: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "login"
        case name
        case avatarUrl = "avatar_url"
        case company, type, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following, plan
        
        case id, url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case subscriptionsUrl = "subscriptions_url"
    }
}

struct Plan: Decodable {
    let plan: String?
    let space: Int
    let collaborators: Int
    let privateRepos: Int
    
    enum CodingKeys: String, CodingKey {
        case plan, space, collaborators
        case privateRepos = "private_repos"
    }
}
