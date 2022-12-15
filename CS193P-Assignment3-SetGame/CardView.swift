//
//  CardView.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 07/12/2022.
//

import SwiftUI

struct CardView: View {
    
    let card: CardGame.Card
    
    var cardColor: Color {
        switch card.content.color {
        case "red":
            return .red
        case "green":
            return .green
        case "purple":
            return .purple
        default:
            return .red
        }
    }
    
    @ViewBuilder
    private func createTypeOfShape<cardShape: Shape> (cardShape: cardShape) -> some View {
        switch card.content.shading {
        case "striped":
            ZStack {
                cardShape
                    .stripify(color: cardColor)
                cardShape
                    .stroke(cardColor, lineWidth: 1)
            }
        case "full":
            cardShape
                .foregroundColor(cardColor)
        default:
            cardShape
                .stroke(lineWidth: 2)
                .foregroundColor(cardColor)
        }
    }
    
    @ViewBuilder
    private func createShape() -> some View {
        switch card.content.shape {
        case "sguiggle":
            createTypeOfShape(cardShape: Sguiggle())
        case "diamond":
            createTypeOfShape(cardShape: Diamond())
        default:
            createTypeOfShape(cardShape: RoundedRectangle(cornerRadius: 20))
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                let cardShape = RoundedRectangle(cornerRadius: 10)
                
                cardShape
                    .fill()
                    .foregroundColor(.white)
                cardShape
                    .strokeBorder(lineWidth: 1)
                    .foregroundColor(.black)
                VStack {

                    ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                        createShape()
                            .frame(width: geometry.size.width/2, height: geometry.size.height/6)
                    }
                    
                }
                if card.isChosen {
                    cardShape
                        .strokeBorder(lineWidth: 3)
                        .foregroundColor(.blue)
                }
                if let isMatched = card.isMatched {
                    cardShape
                        .foregroundColor(isMatched ? .green : .red).opacity(0.5)
                }
                
            }
        }
        
    }
    
//    private struct DrawingConstants {
//        static let symbolFrameWidth: CGFloat = 40
//        static let symbolFrameHeight: CGFloat = 20
//    }
    
}

