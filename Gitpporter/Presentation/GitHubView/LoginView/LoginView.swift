//
//  LoginView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/16.
//

import SwiftUI

struct LoginView: View {
    
    @State private var loadingIndicator: Bool = false
    @State private var loadingAmount: Float = 0.0
    @Binding var reflash: Int
    @ObservedObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var loadingService: LoadingService
    @EnvironmentObject var notificationService: NotificationService
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    private var logoImage: some View {
        Image("icon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80.0, height: 80.0)
    }
    
    private var logoLabel: some View {
        HStack {
            Text("Git")
                .fontWeight(.bold)
            Text("Supportter")
        }
    }
    
    private var contentLabel: some View {
        VStack {
            Text("안녕하세요!".localized())
                .padding()
            Text("깃허브 정보를 이용하기 위해".localized())
            Text("깃허브 로그인을 해주세요!".localized())
        }
    }
    
    private var loginButton: some View {
        
        Link(destination: loginViewModel.login()) {
            HStack {
                Image(systemName: "person.fill")
                Text("깃허브 로그인".localized())
            }
            .onOpenURL(perform: { url in
                self.loadingIndicator = true
                let code = url.absoluteString.components(separatedBy: "code=").last ?? ""
                loginViewModel.requestAccessToken(with: code)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    loadingService.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        reflash += 1
                        self.loadingIndicator = false
                    }
                }
                notificationService.isToggle = true
            })
            .onReceive(self.timer) { _ in
                if (self.loadingIndicator) && (loadingAmount < 100) {
                    loadingAmount += 5
                }
            }
            
            .font(.system(size:20))
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(40.0)
        }
    }
    
    var body: some View {
        ZStack {
            if loadingIndicator {
                ProgressView("유저 정보 확인중...".localized(), value: loadingAmount, total: 100)
                    .backgroundStyle(Color("SubViewBackground"))
                    .shadow(color: Color("ShadowColor"), radius: 1, x: 1, y: 1)
                    .frame(maxWidth: 250)
            }
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
                        .disabled(self.loadingIndicator)
                }
                
                Spacer()
                    .frame(height: 100)
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
