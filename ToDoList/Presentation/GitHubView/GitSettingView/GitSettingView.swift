//
//  GitSettingView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/28.
//

import SwiftUI

struct GitSettingView: View {
    
    @EnvironmentObject var userService: UserService
    @EnvironmentObject var loadingService: LoadingService
    @EnvironmentObject var notificationService: NotificationService
    @State private var wakeUp = Date()
    
    var body: some View {
        List {
            Section(header: Text("UserInfo")) {
                Text("\(userService.userInfo.name)")
                    .font(.headline)
                    .fontDesign(.rounded)
                Text("Email: \(userService.userInfo.email ?? "등록된 이메일이 없어요")")
                Text("Repository: \(userService.userInfo.publicRepos)개")
                Button("로그아웃") {
                    loadingService.isLoading = false
                    userService.logout()
                    print("Logout")
                }
                .tint(.red)
                .font(.headline)
            }
            
            Section(header: Text("Notification")) {
                Toggle(isOn: $notificationService.isToggle) {
                    Text("Notification")
                }
                if notificationService.isToggle {
                    DatePicker("Enter a time", selection: $notificationService.notiTime,
                               displayedComponents: .hourAndMinute)
                    .environment(\.locale, Locale.init(identifier: "ko_KR"))
                }
            }
            
            Section(header: Text("commit Info")) {
                Text("Today: \(userService.commitHistory["today"] ?? 0)개")
                Text("ThisYear: \(userService.commitHistory["thisYear"] ?? 0)개")
                Text("Continues: \(userService.commitHistory["continues"] ?? 0)일")
            }
            
            Section(header: Text("Follow Info")) {
                Text("Followers: \(userService.userInfo.followers)")
                Text("Following: \(userService.userInfo.following)")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Git Setting")
    }
}

struct GitSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GitSettingView()
    }
}
