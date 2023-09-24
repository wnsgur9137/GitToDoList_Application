//
//  CustomTabView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct CustomTabView<Content: View>: View {
    
    let tabs: [TabBarModel]
    
    @Binding var selectedIndex: Int
    
    // ViewBuilder는 여러 logic single statements로 부터 single generic view를 구성하도록 한다.
    // 즉, Closure(Child)에서 View를 구성한다고 생각하면 된다.
    @ViewBuilder let content: (Int) -> Content
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach (tabs.indices) { index in
                    content(index)
                        .tag(index)
                }
            }
            
            VStack {
                Spacer()
                TabBarSubView(tabbarItems: tabs, selectedIndex: $selectedIndex)
            }
            .padding(.bottom, 8)
        }
    }
}
