//
//  LoginView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/16.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    private var logoImage: some View {
        Image(systemName: "apple.logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80.0, height: 80.0)
    }
    
    private var logoLabel: some View {
        HStack {
            Text("Commit")
                .fontWeight(.bold)
            Text("Helper")
        }
    }
    
    private var contentLabel: some View {
        VStack {
            Text("안녕하세요!")
                .padding()
            Text("깃허브 정보를 이용하기 위해")
            Text("깃허브 로그인을 해주세요!")
        }
    }
    
    private var loginButton: some View {
        
        Link(destination: loginViewModel.login()) {
            HStack {
                Image(systemName: "person.fill")
                Text("GitHub Login")
            }
            .onOpenURL(perform: { url in
                let code = url.absoluteString.components(separatedBy: "code=").last ?? ""
                loginViewModel.requestAccessToken(with: code)
            })
            .font(.system(size:20))
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(40.0)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            VStack(alignment: .center, spacing: 40.0) {
                logoImage
                logoLabel
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 40.0) {
                contentLabel
                loginButton
            }
            
            Spacer()
                .frame(height: 100)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
