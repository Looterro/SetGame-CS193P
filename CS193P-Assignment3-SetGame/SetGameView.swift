//
//  SetGameView.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetCardGame
    @Namespace private var dealingNameSpace
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Set")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
            }
            
            if game.cards.count != 0 {

                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .padding(5)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                        .onTapGesture {
                            withAnimation {
                                game.choose(card)
                            }
                        }
                }
                
            } else {
                VStack {
                    Text("Game Over!")
                        .font(.largeTitle)
                }
            }
            
            HStack {
                
                discardedPile
                
                Spacer()
                
                Button {
                    game.newGame()
                } label: {
                    Text("New Game")
                        .font(.title)
                }
                Spacer()

                deckBody
                    .disabled(game.remainingCards.isEmpty)
                
            }
            .padding(30)
        }
        
    }
    
    var discardedPile: some View {
        ZStack {
            ForEach(game.discardedCards) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .opacity))
                    .rotationEffect(Angle.degrees(Double(card.id * card.id)))
            }
        }
        .frame(width: 60 , height: 90)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.remainingCards) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))

            }
        }
        .frame(width: 60 , height: 90)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                game.dealThreeMoreCards()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetGameView(game: game)
    }
}
