//
//  SetGameView.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetCardGame
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                        
                    }
                    
                }
                
            }
            .padding(.horizontal)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetGameView(game: game)
    }
}

struct CardView: View {
    
    let card: CardGame.Card
    
    var cardColor: Color {
        switch card.content.color {
        case "red":
            return .red
        case "green":
            return .green
        case "violet":
            return .purple
        default:
            return .red
        }
    }
    
    @ViewBuilder
    func createTypeOfShape<cardShape: Shape> (cardShape: cardShape) -> some View {
        switch card.content.shading {
        case "striped":
            Stripe(color: cardColor, shape: cardShape)
                .frame(width: DrawingConstants.symbolFrameWidth, height: DrawingConstants.symbolFrameHeight)
        case "full":
            cardShape
                .frame(width: DrawingConstants.symbolFrameWidth, height: DrawingConstants.symbolFrameHeight)
                .foregroundColor(cardColor)
        default:
            cardShape
                .stroke(lineWidth: 3)
                .frame(width: DrawingConstants.symbolFrameWidth, height: DrawingConstants.symbolFrameHeight)
                .foregroundColor(cardColor)
        }
    }
    
    @ViewBuilder
    func createShape() -> some View {
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
                }
                
            }
            
        }
        
    }
    private struct DrawingConstants {
        static let symbolFrameWidth: CGFloat = 40
        static let symbolFrameHeight: CGFloat = 20
    }
}
