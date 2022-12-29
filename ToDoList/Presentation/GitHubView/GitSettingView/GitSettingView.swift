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
    @State private var date: Date = Date()
    @State private var logoutTapped: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("UserInfo")) {
                Text("\(userService.userInfo.name)")
                    .font(.headline)
                    .fontDesign(.rounded)
                Text("Email: \(userService.userInfo.email ?? "등록된 이메일이 없어요")")
                Text("Repository: \(userService.userInfo.publicRepos)개")
                Button("로그아웃") {
                    logoutTapped = !logoutTapped
                }
                .tint(.red)
                .font(.headline)
                .alert(isPresented: $logoutTapped) {
                    Alert(
                        title: Text("로그아웃 하시겠습니까?"),
                        message: nil,
                        primaryButton: .default(Text("아니오")),
                        secondaryButton: .destructive(Text("예"), action: {
                            loadingService.isLoading = false
                            userService.logout()
                            print("Logout")
                        }))
                }
            }
            
            Section(header: Text("Notification")) {
                Toggle(isOn: $notificationService.isToggle) {
                    Text("Notification")
                }
                if notificationService.isToggle {
                    DatePicker("Enter a time", selection: $notificationService.notiTime,
                               displayedComponents: .hourAndMinute)
                        .environment(\.locale, Locale.init(identifier: "ko_KR"))
                        .environment(\.timeZone, TimeZone(abbreviation: "KST")!)
                    Text("\(notificationService.notiTime)")
                    Text("\(date)")
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
//        .alert(isPresented: $notificationService.isAlertOccurred) {
//            Alert(
//                title: Text("설정되지 않음"),
//                message: Text("설정으로 이동하시겠습니까?"),
//                primaryButton: .default(Text("Cancel"), action: {
//                    notificationService.isToggle = false
//                }),
//                secondaryButton: .cancel(Text("Go to Settings"), action: {
//                    notificationService.isToggle = false
//                    notificationService.openSettings()
//                }))}
    }
}

struct GitSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GitSettingView()
    }
}

//                    .environment(\.timeZone, TimeZone(identifier: "KST") ?? <#default value#>)
