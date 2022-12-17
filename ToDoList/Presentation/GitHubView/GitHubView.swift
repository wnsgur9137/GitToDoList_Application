//
//  GitHubView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct GitHubView: View {
    var body: some View {
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
                    
                    ChallengeStack()
//                    ContributionView()
                    
                } // VStack
                .navigationTitle("GitHub")
            } // ScrollView
//            .background(Color.green)
            .background(LinearGradient(gradient: Gradient(colors: [Color("BackgroundColor1"), Color("BackgroundColor2")]), startPoint: .top, endPoint: .bottom))
        } // NavigationView
    } // var body
} // struct GitHubView

struct GitHubView_Previews: PreviewProvider {
    static var previews: some View {
        GitHubView()
    } // static var previews
} // GitHubView_Previews
