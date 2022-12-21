//
//  CardModifier.swift
//  ToDoList
//
//  Created by 이준혁 on 2022/12/16.
//

import Foundation
import SwiftUI

struct CardModifier: ViewModifier {
    
    let width: CGFloat
    let height: CGFloat
    
    init(height: CGFloat) {
        self.width = uiSize.width * widthRatio.card
        self.height = height
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(color: Color("ShadowColor"), radius: 1, x: 1, y: 1)
                    .opacity(0.3)
            )
    }
}
