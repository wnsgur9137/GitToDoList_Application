//
//  FSCalendarView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/15.
//

import SwiftUI
import FSCalendar

struct CalendarModuleViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CalendarModuleViewController>) -> UIViewController {
        let viewController = CalendarModule()
        viewController.calendar.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CalendarModuleViewController>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: NSObject, FSCalendarDelegate {
        private var parent: CalendarModuleViewController
        
        
        init (_ parent: CalendarModuleViewController) {
            self.parent = parent
        }
        
    }
}

struct CalendarModuleView: View {
    
    var body: some View {
        CalendarModuleViewController()
    }
    
}
