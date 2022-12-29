//
//  NotificiationService.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/28.
//

import SwiftUI
import UserNotifications

class NotificationService: ObservableObject {
    
    let notiCenter = UNUserNotificationCenter.current()
    
    @Published var isCommited: Bool = UserDefaults.standard.bool(forKey: "commitDataBool") {
        didSet {
//            removeAllNotifications()
//            if isCommited {
//                requestNotiAuthorization()
//            } else {
//                removeAllNotifications()
//            }
        }
    }
    
    @Published var isToggle: Bool = UserDefaults.standard.bool(forKey: "notiBool") {
        didSet {
            print("isToggle: \(isToggle)")
            if isToggle {
                UserDefaults.standard.set(true, forKey: "notiBool")
                self.requestNotiAuthorization()
            } else {
                self.removeAllNotifications()
                UserDefaults.standard.set(false, forKey: "notiBool")
            }
        }
    }
    
    @Published var notiTime: Date = ((UserDefaults.standard.string(forKey: "notiTime"))?.toNoticeTime() ?? Date()) {
        didSet {
            print("notiTime: \(notiTime)")
            self.removeAllNotifications()
            let stringNotiTime = notiTime.toNoticeString
            UserDefaults.standard.set(stringNotiTime, forKey: "notiTime")
            self.requestNotiAuthorization()
            self.addNotification(with: self.notiTime)
        }
    }
    
    @Published var isAlertOccurred: Bool = false
    
    func removeAllNotifications() {
        notiCenter.removeAllDeliveredNotifications()
        notiCenter.removeAllPendingNotificationRequests()
    }
    
    func requestNotiAuthorization() {
        print("requestNotiAuthorization()")
        notiCenter.getNotificationSettings { settings in
            /// 승인되어 있지 않은 경우
            if settings.authorizationStatus != .authorized {
                self.notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if let error = error {
                        print("Notification Error: \(error)")
                    }
                    print("granted: \(granted)")
                    if granted { /// Notification 최초 승인
                        self.addNotification(with: self.notiTime)
                        print("addNotification()")
                    } else { /// Notification 최초 거부
                        DispatchQueue.main.async {
                            self.isToggle = false
                        }
                    }
                }
            }
            
            /// 거부되어있는 경우 alert
            if settings.authorizationStatus == .denied {
                /// 알림 띄운 뒤 설정 창으로 이동
                DispatchQueue.main.async {
                    self.isAlertOccurred = true
                }
            }
        }
    }
    
    func addNotification(with time: Date) {
        let content = UNMutableNotificationContent()
        
        content.title = "Git 도우미"
        content.subtitle = "커밋"
        content.sound = UNNotificationSound.default
        
        print("time: \(time)")
        
        let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: time)
        print("dateComponent: \(dateComponent)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notiCenter.add(request) { error in
            print("Notification Add Error: \(String(describing: error?.localizedDescription))")
        }
    }
    
    func openSettings() {
       if let bundle = Bundle.main.bundleIdentifier,
          let settings = URL(string: UIApplication.openSettingsURLString + bundle) {
            if UIApplication.shared.canOpenURL(settings) {
               UIApplication.shared.open(settings)
            }
        }
    }
}
