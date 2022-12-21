//
//  CommitHistoryStack.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/14.
//

import SwiftUI

struct CommitHistoryStack: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("커밋 기록")
                .font(.headline)
                .fontDesign(.rounded)
                .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 0.0))
            
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
                    Image(systemName: "flame.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
//                        .clipShape(Circle())
//                        .border(.blue)
                        .foregroundColor(.red)
                        .padding()
                    Text("1개")
                    Text("이번주")
                }
                VStack(alignment: .center, spacing: 5.0) {
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
                        .padding()
//                        .clipShape(Circle())
//                        .border(.blue)
                    Text("1개")
                    Text("올해")
                }
            }
        }
        .padding(EdgeInsets(top: 20.0, leading: 30.0, bottom: 20.0, trailing: 30.0))
        .background(Color("SubViewBackground"))
        .cornerRadius(16.0)
        .shadow(color: Color("ShadowColor"), radius: 5, x: 5.0, y:5.0)
    }
}

struct CommitHistoryStack_Previews: PreviewProvider {
    static var previews: some View {
        CommitHistoryStack()
    }
}
