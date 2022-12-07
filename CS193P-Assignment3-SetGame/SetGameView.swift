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
            if game.cards.count != 0 {

                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    CardView(card: card)
                        .padding(5)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
                
            } else {
                VStack {
                    Text("Game Over!")
                        .font(.largeTitle)
                }
            }
            
            HStack {
                Button {
                    game.newGame()
                } label: {
                    Text("New Game")
                        .font(.title)
                }
                Spacer()
                Button {
                    game.dealThreeMoreCards()
                } label: {
                    Text("Add Cards")
                        .font(.title)
                }
                .disabled(game.remainingCards.isEmpty)
                
            }
            .padding(30)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetGameView(game: game)
    }
}
