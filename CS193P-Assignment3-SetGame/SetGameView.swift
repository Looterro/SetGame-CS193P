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
            
            HStack {
                
                Text("Set")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Spacer()
                
                Text("Score : \(game.score)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
            }
            .padding()
            
            if game.cards.count != 0 || game.remainingCards.count != 0 {
            
            gameBody
                
            
            HStack {
                
                discardedPile
                
                Spacer()
                
                newGameButton
                
                Spacer()
                
                Button("Cheat") {
                    withAnimation {
                        game.cheat()
                    }

                }
                
                Spacer()
                
                deckBody
                
            }
            .padding()
                
                
            } else {
                
                Spacer()
                
                Text("Game Over!")
                    .font(.largeTitle)
                Text("Highest score: \(game.highest)")
                
                Spacer()
                
                newGameButton
                
                Spacer()
                
            }
            
        }
        
    }
    
    var newGameButton: some View {
        VStack {
            Button("New game") {
                withAnimation(.linear(duration: 0.2)) {
                    dealt = []
                    game.newGame()
                }
                for card in game.cards.filter(isUndealt) {
                    withAnimation(dealAnimation(for: card)) {
                        deal(card)
                    }
                }
            }
        }
    }
    
    var discardedPile: some View {
        ZStack {
            ForEach(game.discardedCards) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                    .rotationEffect(Angle.degrees(Double(card.id * card.id)))
            }
        }
        .frame(width: 60 , height: 90)
    }
    
    var gameBody: some View {
        
        VStack {
            
                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    if isUndealt(card) {
                        Color.clear
                    } else {
                        CardView(card: card)
                            .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                            .padding(5)
                            .transition(.asymmetric(insertion: .opacity, removal: .scale))
                            .onTapGesture {
                                withAnimation {
                                    game.choose(card)
                                }
                            }
                    }
                }
                .onAppear{
                    for card in game.cards.filter(isUndealt) {
                        withAnimation(dealAnimation(for: card)) {
                            deal(card)
                        }
                    }
                }
            
        }

    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.remainingCards) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .onTapGesture {
                        
                        withAnimation(.linear(duration: 0.2)) {
                            game.dealThreeMoreCards()
                        }
                        for card in game.cards.filter(isUndealt) {
                            withAnimation(dealAnimation(for: card, dealThree: true)) {
                                deal(card)
                            }
                        }
                        
                    }

            }
        }
        .frame(width: 60 , height: 90)
        .disabled(game.remainingCards.isEmpty)
    }
    
    @Namespace private var dealingNameSpace
    @State private var dealt = Set<Int>()

    
    
    private func isUndealt(_ card: CardGame.Card) -> Bool {
        !dealt.contains(card.id)
    }

    private func deal(_ card: CardGame.Card) {
        dealt.insert(card.id)
    }

    private func dealAnimation(for card: CardGame.Card, dealThree: Bool = false) -> Animation {
        var delay = 0.0
        
        if dealThree == false {
            if let index = game.cards.firstIndex(where: {$0.id == card.id }) {
                delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
            }
            return Animation.linear(duration: 0.5).delay(delay)
        }
        
        if let index = game.cards.reversed().filter(isUndealt).firstIndex(where: {$0.id == card.id }) {
            delay = 0.4 - Double(index) / 3
        }
        return Animation.linear(duration: 0.5).delay(delay)
        
    }
    
    private struct CardConstants {
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetGameView(game: game)
    }
}
