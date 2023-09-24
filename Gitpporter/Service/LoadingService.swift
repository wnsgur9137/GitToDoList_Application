//
//  LoadingService.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/20.
//

import SwiftUI

class LoadingService: ObservableObject {
    @Published var isLoading: Bool
    
    init() {
        self.isLoading = UserDefaults.standard.string(forKey: "userID") == "" ? false : true
    }
}
