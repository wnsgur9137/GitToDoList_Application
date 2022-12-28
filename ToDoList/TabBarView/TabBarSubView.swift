//
//  TabBarSubView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct TabBarSubView: View {
    
    let tabbarItems: [TabBarModel]
    var height = 70.0
    var width = UIScreen.main.bounds.width - 32.0
    
    // @Binding Annoation을 붙이면 Binding<Type>을 인자로 받아 초기화할 수 있다.
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            ForEach(tabbarItems.indices) { index in
                let item = tabbarItems[index]
                Button {
                    self.selectedIndex = index
                } label: {
                    let isSelected = selectedIndex == index
                    TabBarItemView(data: item, isSelected: isSelected)
                }
                Spacer()
            }
        }
        .frame(width: self.width, height: self.height)
        .background(Color("BackgroundColor1"))
        .cornerRadius(13.0)
        .shadow(radius: 5, x: 0, y: 4)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let tabbarItems = [
            TabBarModel(image: "person", selectedImage: "person.fill", title: "Profile"),
            TabBarModel(image: "person", selectedImage: "person.fill", title: "Profile"),
            TabBarModel(image: "person", selectedImage: "person.fill", title: "Profile"),
            TabBarModel(image: "person", selectedImage: "person.fill", title: "Profile")
        ]
        TabBarSubView(tabbarItems: tabbarItems, selectedIndex: .constant(0))
    }
}
