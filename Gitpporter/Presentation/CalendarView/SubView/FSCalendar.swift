//
//  FSCalendar.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/27.
//

import SwiftUI
import Combine
import FSCalendar

//CalendarModule.swift:
class CalendarModule: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    private var subs: [AnyCancellable] = []
    @ObservedObject var eventService: EventService = EventService()
    private let countLabel = UILabel(frame: .zero)
    var calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.locale = Locale(identifier: "ko_KR")
        setCalendarUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initCalendar()
        view.addSubview(calendar)
    }
    
    private func initCalendar() {
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width)
        calendar.appearance.todayColor = UIColor.systemGreen
        calendar.appearance.selectionColor = UIColor.systemBlue
    }
    
    private func setSwipeEvent() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .up {
            calendar.setScope(.week, animated: true)
            self.calendar.headerHeight = 60.0
            print("up")
        } else if swipe.direction == .down {
            calendar.setScope(.month, animated: true)
            self.calendar.headerHeight = 100.0
            self.calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 4)
            print("down")
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.eventService.tapCount += 1
        self.eventService.date = date
        print(eventService.tapCount)
        print(eventService.date)
    }
    
    func setCalendarUI() {
        self.calendar.appearance.eventDefaultColor = UIColor(.green)
        self.calendar.appearance.eventSelectionColor = UIColor(.green)
        self.calendar.appearance.headerTitleAlignment = .center
        self.calendar.appearance.weekdayTextColor = UIColor(.green)
        self.calendar.calendarWeekdayView.weekdayLabels[0].textColor = .systemRed
        self.calendar.calendarWeekdayView.weekdayLabels[6].textColor = .systemBlue
        self.calendar.layer.cornerRadius = 10
    }
}
