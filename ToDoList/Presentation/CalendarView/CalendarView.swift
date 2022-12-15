//
//  CalendarView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct CalendarView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Spacer()
                    CalendarModuleView()
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text("Details")
                    Spacer()
                }
            }
            .navigationTitle("Calendar")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
