//
//  ProfileStack.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI
import Kingfisher

struct ProfileStack: View {
    
    @EnvironmentObject var userService: UserService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            let userName = UserDefaults.standard.string(forKey: "userID")
            
            Text("\(userName ?? "알 수 없음")님")
                .font(.headline)
                .fontDesign(.rounded)
                .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 0.0))
            
            HStack(alignment: .center, spacing: 30.0) {
                KFImage(URL(string:userService.userInfo.avatarUrl!))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100.0, height: 100.0)
                    .cornerRadius(50.0)
                
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("\(userService.userInfo.name)")
                        .frame(width: 210.0, alignment: .leading)
                        .font(.headline)
                    Text("\(userService.userInfo.email ?? "등록된 이메일이 없어요.")")
                        .frame(width: 210.0, alignment: .leading)
                    Text("오늘 커밋을 완료했어요!")
                        .foregroundColor(.green)
                    Text("오늘 커밋을 하지 않았어요!")
                        .foregroundColor(.red)
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
        ProfileStack()
    }
}
