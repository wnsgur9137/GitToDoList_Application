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
        }
    }
    
    @Published var isToggle: Bool = UserDefaults.standard.bool(forKey: "notiBool") {
        didSet {
            print("isToggle: \(isToggle)")
            if isToggle {
                UserDefaults.standard.set(true, forKey: "notiBool")
                print("isToggle")
                self.requestNotiAuthorization()
            } else {
                print("notToggle")
                self.removeAllNotifications()
                UserDefaults.standard.set(false, forKey: "notiBool")
            }
        }
    }
    
    @Published var notiTime: Date = ((UserDefaults.standard.string(forKey: "notiTime"))?.toNotificationTime() ?? Date()) {
        didSet {
            // UserDefaults
            let stringNotiTime = notiTime.toNotificationString
            UserDefaults.standard.set(stringNotiTime, forKey: "notiTime")
            
            // Notifications
            print("removeAllNotifications")
            self.removeAllNotifications()
            print("requestNotifications")
            self.requestNotiAuthorization()
        }
    }
    
    @Published var isAlertOccurred: Bool = false
    
    func removeAllNotifications() {
        notiCenter.removeAllDeliveredNotifications()
        notiCenter.removeAllPendingNotificationRequests()
    }
    
    func requestNotiAuthorization() {
        notiCenter.getNotificationSettings { settings in
            /// 승인되어 있지 않은 경우
            
            switch settings.authorizationStatus {
            case .authorized:
                self.addNotification(with: self.notiTime)
            case .denied:
                DispatchQueue.main.async {
                    print(self.isAlertOccurred)
                    self.isAlertOccurred = !self.isAlertOccurred
                    print("denied")
                    print(self.isAlertOccurred)
                }
            default:
                self.notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if let error = error {
                        print("Notification Error: \(error)")
                    }
                    print("granted: \(granted)")
                    if granted { /// Notification 최초 승인
                        self.addNotification(with: self.notiTime)
                    } else { /// Notification 최초 거부
                        DispatchQueue.main.async { [weak self] in
                            self?.isAlertOccurred = !(self?.isAlertOccurred ?? false)
                            self?.isToggle = false
                        }
                    }
                }
            }
        }
    }
    
    func addNotification(with time: Date) {
        let content = UNMutableNotificationContent()
        
        content.title = "Git 도우미"
        content.subtitle = "커밋"
        content.sound = UNNotificationSound.default
        content.body = "Content Body"
        
        print("addNotificationTime: \(time)")
        let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: time)
        print("dateComponent: \(dateComponent)")
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger1)
        
        notiCenter.add(request) { error in
            guard error == nil else { return }
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
