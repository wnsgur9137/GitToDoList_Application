//
//  CalendarView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var eventService: EventService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        Spacer()
                            .frame(height: 1.0)
                        CalendarModuleView()
                            .frame(height:400.0)
                            .cornerRadius(15.0)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.gray)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                    }
                    
                    VStack {
                    Text("Details")
                    Text("\(eventService.tapCount)번")
                    Text("\(eventService.date)일")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.gray)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        )
                    }
                    
                    Spacer()
                }
                .background(.background)
                .navigationTitle("Calendar")
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
