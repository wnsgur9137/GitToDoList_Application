//
//  GitHubView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct GitHubView: View {
    @State var reflash: Int = 0
    @State var accessToken: String = ""
    
    @EnvironmentObject var userService: UserService
    @EnvironmentObject var loadingService: LoadingService
    @EnvironmentObject var notificationService: NotificationService
    @ObservedObject var accessTokenObject: LoginViewModel = LoginViewModel()
    
    var body: some View {
        
//        let userID = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
//        let loading = loadingService.isLoading
//        let islogin = userService.isLogin
//        if islogin == false {
        if userID == "" {
            VStack {
                Text("reflash: \(reflash)")
                    .hidden()
                Text("userdefaults: \(UserDefaults.standard.string(forKey: "userID") ?? "알 수 없음".localized())")
                    .hidden()
                LoginView(reflash: $reflash)
            }
        } else {
            NavigationView {
                ScrollView {
                    VStack(alignment: .center, spacing: 50.0) {
                        ProfileStack()
                            .frame(
                                minWidth: 400.0, maxWidth: .infinity,
                                minHeight: 160.0, maxHeight: 180.0
                            )
                        
                        CommitHistoryStack()
                            .frame(
                                minWidth: 400.0, maxWidth: .infinity,
                                minHeight: 160.0, maxHeight: 300.0
                            )
                        
//                        ChallengeStack()
                        
                        ContributionView()
                        
                        InformationView()
                            .frame(
                                minWidth: 400.0, maxWidth: .infinity,
                                minHeight: 160.0, maxHeight: 300.0
                            )
                        
                        Text("userID: \(userID)")
                            .hidden()
                        Text("reflash: \(reflash)")
                            .hidden()
                        
                    } /// VStack
                    .navigationTitle("Gitpportter")
                    .navigationBarItems(
                        trailing: NavigationLink(
                            destination: GitSettingView(),
                            label: {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.green)
                            }
                        )
                    )
                } /// ScrollView
    //            .background(Color.green)
                .background(LinearGradient(gradient: Gradient(colors: [Color("BackgroundColor1"), Color("BackgroundColor2")]), startPoint: .top, endPoint: .bottom))
            } /// NavigationView
            .onAppear {
                userService.getUserInfo()
                userService.getCommitData()
                reflash+=1
            }
            .refreshable {
                userService.getUserInfo()
                userService.getCommitData()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.reflash += 1
                }
            }
        } /// else
    } /// var body
} /// struct GitHubView

struct GitHubView_Previews: PreviewProvider {
    static var previews: some View {
        GitHubView()
    } // static var previews
} // GitHubView_Previews
