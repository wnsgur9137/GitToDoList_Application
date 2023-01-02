//
//  EventMessenger.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/27.
//

import Foundation

class EventService: ObservableObject {
    @Published var tapCount: Int = 0
    @Published var date: Date = Date()
}
