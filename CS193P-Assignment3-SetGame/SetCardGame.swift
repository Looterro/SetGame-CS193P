//
//  SetMemoryGame.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import Foundation
import SwiftUI

class SetCardGame: ObservableObject {
    
    private static let shapes = ["diamond", "sguiggle", "oval"]
    private static let shading = ["hollow", "full", "striped"]
    private static let colors = ["red", "green", "purple"]
    
    private static func createSetGame() -> CardGame {
        
        var cardsContents: [CardContent] = []
        
        for color in colors {
            for shape in shapes {
                for shade in shading {
                    for num in 1...3 {
                        cardsContents.append(CardContent(shape: shape, color: color, numberOfShapes: num, shading: shade))
                    }
                }
            }
        }
        return CardGame(cardsContents)
    }
    
    @Published private var model = createSetGame()
    
    var cards: [CardGame.Card] {
        model.playingCards
    }
    
    func choose(_ card: CardGame.Card) {
        model.choose(card)
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
    
    func newGame () {
        model = Self.createSetGame()
    }
}
