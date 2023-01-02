//
//  InformationView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/20.
//

import SwiftUI

struct InformationView: View {
    
    @EnvironmentObject var userService: UserService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("정보".localized())
                .font(.headline)
                .fontDesign(.rounded)
                .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 0.0))
            
            HStack(alignment: .center, spacing: 30.0) {
                VStack(alignment: .center, spacing: 5.0) {
                    Image(systemName: "folder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
                        .padding()
                    Text("%d개".localized(with: userService.userInfo.publicRepos))
                    Text("리파지토리".localized())
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .center, spacing: 5.0) {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
//                        .clipShape(Circle())
//                        .border(.blue)
                        .padding()
                        .cornerRadius(30.0)
                    Text("%d명".localized(with: userService.userInfo.followers))
                    Text("팔로워".localized())
                }
                VStack(alignment: .center, spacing: 5.0) {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
                        .foregroundColor(.pink)
                        .padding()
//                        .clipShape(Circle())
//                        .border(.blue)
                    Text("%d명".localized(with: userService.userInfo.following))
                    Text("팔로잉".localized())
                }
            }
        }
        .padding(EdgeInsets(top: 20.0, leading: 30.0, bottom: 20.0, trailing: 30.0))
        .background(Color("SubViewBackground"))
        .cornerRadius(16.0)
        .shadow(color: Color("ShadowColor"), radius: 5, x: 5.0, y:5.0)
    }
}

struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
