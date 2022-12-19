//
//  RepositorysView.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/18.
//

import SwiftUI

struct RepositorysView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Repositorys")
                .font(.headline)
                .fontDesign(.rounded)
                .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 12.0, trailing: 0.0))
            
            HStack(alignment: .center, spacing: 30.0) {
                VStack(alignment: .center, spacing: 5.0) {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
                        .padding()
                    Text("1개")
                    Text("오늘")
                }
                
                VStack(alignment: .center, spacing: 5.0) {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
                        .padding()
                    Text("1개")
                    Text("오늘")
                }
            }
        }
    }
}

struct RepositorysView_Previews: PreviewProvider {
    static var previews: some View {
        RepositorysView()
    }
}
