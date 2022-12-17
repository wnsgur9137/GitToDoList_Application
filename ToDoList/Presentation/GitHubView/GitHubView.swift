//
//  GitHubView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct GitHubView: View {
    @State var reflash: Int = 0
    
    var body: some View {
        
        let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        if userID == "" {
            VStack {
                Text("reflash: \(reflash)")
                    .hidden()
                Text("userdefaults: \(UserDefaults.standard.string(forKey: "userID") ?? "없음")")
                    .hidden()
                LoginView(reflash: $reflash)
            }
        } else {
            NavigationView {
                ScrollView {
                    Text("userID: \(userID)")
                        .hidden()
                    Text("reflash: \(reflash)")
                        .hidden()
                    VStack(alignment: .center, spacing: 50.0) {
                        ProfileStack(reflash: self.$reflash)
                            .frame(
                                minWidth: 400.0, maxWidth: .infinity,
                                minHeight: 160.0, maxHeight: 180.0
                            )
                        
                        CommitHistoryStack()
                            .frame(
                                minWidth: 400.0, maxWidth: .infinity,
                                minHeight: 160.0, maxHeight: 300.0
                            )
                        
                        ChallengeStack()
    //                    ContributionView()
                        
                    } // VStack
                    .navigationTitle("GitHub")
                } // ScrollView
    //            .background(Color.green)
                .background(LinearGradient(gradient: Gradient(colors: [Color("BackgroundColor1"), Color("BackgroundColor2")]), startPoint: .top, endPoint: .bottom))
            } // NavigationView
        }
        
        
    } // var body
} // struct GitHubView

struct GitHubView_Previews: PreviewProvider {
    static var previews: some View {
        GitHubView()
    } // static var previews
} // GitHubView_Previews
