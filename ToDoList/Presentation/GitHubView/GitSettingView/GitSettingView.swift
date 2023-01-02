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
            Section(header: Text("유저 정보".localized())) {
                Text("\(userService.userInfo.name)")
                    .font(.headline)
                    .fontDesign(.rounded)
                Text("이메일: %@".localized(with: userService.userInfo.email ?? "등록된 이메일이 없어요".localized()))
                Text("리파지토리: %d개".localized(with: userService.userInfo.publicRepos))
                Button("로그아웃".localized()) {
                    logoutTapped = !logoutTapped
                }
                .tint(.red)
                .font(.headline)
                .alert(isPresented: $logoutTapped) {
                    Alert(
                        title: Text("로그아웃 하시겠습니까?".localized()),
                        message: nil,
                        primaryButton: .default(Text("아니오".localized())),
                        secondaryButton: .destructive(Text("예".localized()), action: {
                            loadingService.isLoading = false
                            userService.logout()
                            print("Logout")
                        }))
                }
            }
            
            Section(header: Text("알림".localized())) {
                Toggle(isOn: $notificationService.isToggle) {
                    Text("알림".localized())
                }
                if notificationService.isToggle {
                    DatePicker("알림 시간".localized(), selection: $notificationService.notiTime,
                               displayedComponents: .hourAndMinute)
//                        .environment(\.locale, Locale.init(identifier: "ko_KR"))
                        .environment(\.timeZone, TimeZone(abbreviation: "KST")!)
//                    Text("\(notificationService.notiTime)")
//                    Text("\(date)")
                }
            }
            
            Section(header: Text("커밋 정보".localized())) {
                Text("오늘: %d개".localized(with: userService.commitHistory["today"] ?? 0))
                Text("일년: %d개".localized(with: userService.commitHistory["thisYear"] ?? 0))
                Text("연속: %d일".localized(with: userService.commitHistory["continues"] ?? 0))
            }
            
            Section(header: Text("팔로우 정보".localized())) {
                Text("팔로워: %d명".localized(with: userService.userInfo.followers))
                Text("팔로잉: %d명".localized(with: userService.userInfo.following))
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("깃 설정".localized())
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
