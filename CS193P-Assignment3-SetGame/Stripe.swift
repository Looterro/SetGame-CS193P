//
//  Stripe.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 07/12/2022.
//

import SwiftUI

struct Stripe<ShapeForm: Shape>: View {
    
    let color: Color
    let shape: ShapeForm
    
    var body: some View {
        HStack(spacing: 0.5) {
            ForEach(0..<7) { _ in
                Color(.white)
                color
            }
            Color(.white)
        }
        //put stripes over the given shape
        .mask(shape)
        //add border
        .overlay(shape.stroke(color, lineWidth: 1.3))
    }
}
