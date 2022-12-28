//
//  ContributionView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI
import Alamofire
import Kingfisher

struct ContributionView: View {
    @EnvironmentObject private var userService: UserService
//    @EnvironmentObject var colorThemeService: ColorThemeService
    private let weekday = Calendar.current.component(.weekday, from: Date())
//    private let width: CGFloat = uiSize.width * widthRatio.card - 20
    @Namespace var endID
    
    @ViewBuilder
    func CommitBox(_ commitLevel:Int) -> some View {
        if commitLevel == 0 {
            RoundedRectangle(cornerRadius: 2.0)
                .foregroundColor(Color(.systemGray6))
                .frame(width: 15.0, height: 15.0)
        } else {
            RoundedRectangle(cornerRadius: 2.0)
                .foregroundColor(.green)
                .frame(width: 15.0, height: 15.0)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Commit Contribution")
                .font(.headline)
                .fontDesign(.rounded)
                .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 0.0))
            ScrollViewReader { scroll in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 5.0) {
                        let count = ceil(Double(userService.commits.count)/Double(7))
                        ForEach(0..<Int(count), id: \.self) { col in
                            VStack(spacing: 5.0) {
                                ForEach(0..<7, id: \.self) { row in
                                    let index = ((col * 7) + row)
                                    if index < userService.commits.count {
                                        CommitBox(userService.commits[index].level)
                                    }
                                }
                            }
                        }
                        VStack {}.id(endID)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                            withAnimation { scroll.scrollTo(endID) }
                        }
                    }
                }
            }
        }
        .padding(20.0)
        .background(Color("SubViewBackground"))
        .cornerRadius(16.0)
        .shadow(color: Color("ShadowColor"), radius: 5, x: 5.0, y:5.0)
        .frame(width: 380.0)
    }
}

struct ContributionView_Previews: PreviewProvider {
    static var previews: some View {
        ContributionView()
    }
}
