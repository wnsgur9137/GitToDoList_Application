//
//  LoadingService.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/20.
//

import SwiftUI

class LoadingService: ObservableObject {
    @Published var isLoading: Bool
//    @Published var loadingIndicator: Bool
//    @Published var loadingAmount: Float
    
    init() {
        self.isLoading = UserDefaults.standard.string(forKey: "userID") == "" ? false : true
//        self.loadingIndicator = false
//        self.loadingAmount = 0.0
    }
}
