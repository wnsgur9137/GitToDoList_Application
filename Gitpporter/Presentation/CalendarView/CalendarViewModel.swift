//
//  CalendarViewModel.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import Foundation
import Alamofire

struct CalendarViewModel {
    
    func getCalendarData() {
        let id = "wnsgur9137"
        
        let query =
        """
        {
        \"query\": \"query { user(login: \\\"\(id)\\\"){ contributionsCollection { contributionCalendar { totalContributions weeks { contributionDays { contributionCount date } } } } } }\"
        }
        """
        let graphQLURL: URL = URL(string: "https://api.github.com/graphql")!
        var request:URLRequest = URLRequest(url: graphQLURL)
        let data = query.data(using: .utf8)

        request.httpMethod = HTTPMethod.post.rawValue // Set Method
        request.setValue("bearer " + APIKeys.githubAPI, forHTTPHeaderField: "Authorization") // Set Header
        request.httpBody = data // Set Body
        AF.request(request).responseJSON { response in
            switch response.result {
            case .success(let response) :
                if let res = response as? [String: Any] {
                    print(res)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
