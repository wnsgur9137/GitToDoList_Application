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
    private let weekday = Calendar.current.component(.weekday, from: Date())
    private let width: CGFloat = uiSize.width * widthRatio.card - 20
    @Namespace var end
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            
        }
    }
}

struct ContributionView_Previews: PreviewProvider {
    static var previews: some View {
        ContributionView()
    }
}
