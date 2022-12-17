//
//  ProfileStack.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct ProfileStack: View {
    
    @Binding var reflash: Int
    
    let userService = UserService()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("깃허브 닉네임")
                .font(.headline)
                .fontDesign(.rounded)
                .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 12.0, trailing: 0.0))
            
            HStack(alignment: .center, spacing: 30.0) {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50.0, height: 50.0)
                    .padding()
//                    .clipShape(Circle())
//                    .border(.blue)
                
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("GitHub 닉네임")
                        .frame(width: 210.0, alignment: .leading)
                    Button("로그아웃") {
                        userService.logout()
                        reflash += 1
                        print("Logout")
                    }
                }
            }
        }
        .padding(20.0)
        .background(Color.white)
        .cornerRadius(16.0)
        .shadow(color: .gray, radius: 5, x: 5.0, y:5.0)
    }
}

struct ProfileStack_Previews: PreviewProvider {
    static var previews: some View {
        let githubview = GitHubView()
        ProfileStack(reflash: githubview.$reflash)
    }
}
