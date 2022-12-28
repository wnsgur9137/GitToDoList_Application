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
//    private var eventService: EventService = EventService()
//    @EnvironmentObject var eventService: EventService
    @ObservedObject var eventService: EventService = EventService()
    private let countLabel = UILabel(frame: .zero)
    var calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.locale = Locale(identifier: "ko_KR")
//        calendar.locale = Locale(identifier: "en_US")
        setCalendarUI()
//        setSwipeEvent()
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
//        self.calendar.headerHeight = bounds.height
        
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
        // 이벤트 색상
        self.calendar.appearance.eventDefaultColor = UIColor(.green)
        self.calendar.appearance.eventSelectionColor = UIColor(.green)
        // 일~월 글자 폰트 및 사이즈
//        self.calendar.appearance.weekdayFont =
        
        // 숫자, 글자 폰트 및 사이즈
//        self.calendar.appearance.titleFont =
        
//        self.calendar.appearance.headerDateFormat = "YYYY년 MM월"
//        self.calendar.appearance.headerTitleFont =
//        self.calendar.appearance.headerTitleColor = UIColor(.green)
        self.calendar.appearance.headerTitleAlignment = .center
        
        // 요일 글자 색상
        self.calendar.appearance.weekdayTextColor = UIColor(.green)
//            .withAlphaComponent(0.2)
        // 일요일 색상
        self.calendar.calendarWeekdayView.weekdayLabels[0].textColor = .systemRed
        // 토요일 색상
        self.calendar.calendarWeekdayView.weekdayLabels[6].textColor = .systemBlue
        
        // 캘린더의 cornerRadius
        self.calendar.layer.cornerRadius = 10
        // 양옆 연도, 월 지우기
//        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // 달에 유효하지 않은 날짜의 색 지정
//        self.calendar.appearance.titleDefaultColor = UIColor.white.withAlphaComponent(0.5)
        // 평일 날짜 색
//        self.calendar.appearance.titleDefaultColor = UIColor.white.withAlphaComponent(0.5)
        // 달에 유효하지 않은 날짜 지우기
//        self.calendar.placeholderType = .none
        
        // 캘린더 숫자와 subtitle간의 간격 조정
//        self.calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 4)
//
//        self.calendar.select(selectedDate)
    }
    
    // title의 디폴트 색상
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        return UIColor.green.withAlphaComponent(0.5)
//    }
}
