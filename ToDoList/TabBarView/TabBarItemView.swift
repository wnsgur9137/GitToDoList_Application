//
//  TabBarItemView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct TabBarItemView: View {
    
    let data: TabBarModel
    let isSelected: Bool
    
    var body: some View {
        VStack {
            let image = isSelected ? data.selectedImage : data.image
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(isSelected ? .green : .gray)
                .animation(.default)
            
            Spacer().frame(height: 4.0)
            
            Text(data.title)
                .foregroundColor(isSelected ? .green : .gray)
                .font(.headline)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let data = TabBarModel(image: "person", selectedImage: "person.fill", title: "Profile")
        TabBarItemView(data: data, isSelected: true)
    }
}
