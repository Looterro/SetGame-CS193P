//
//  Stripify.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 14/12/2022.
//

import SwiftUI

struct Stripify: ViewModifier {
   
    let color: Color
    
    func body(content: Content) -> some View {
        
        ZStack {
            content
                .mask {
                    HStack(spacing: 1.1) {
                        ForEach(0..<5) { _ in
                            Color(.white)
                            color
                        }
                        Color(.white)
                    }
                }
                .foregroundColor(color)
        }
        
    }
    
}


extension View {
    func stripify(color: Color) -> some View {
        self.modifier(Stripify(color: color))
    }
}
