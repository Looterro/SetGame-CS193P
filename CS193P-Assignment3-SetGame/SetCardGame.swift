//
//  SetMemoryGame.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import Foundation
import SwiftUI

class SetCardGame: ObservableObject {
    
    enum colors: String, CaseIterable {
        case red
        case green
        case purple
    }
    
    enum shapes: String, CaseIterable {
        case diamond
        case sguiggle
        case oval
    }
    
    enum shading: String, CaseIterable {
        case hollow
        case full
        case striped
    }
    
    private static func createSetGame() -> CardGame {
        
        var cardsContents: [CardContent] = []
        
        for color in colors.allCases {
            for shape in shapes.allCases {
                for shade in shading.allCases {
                    for num in 1...3 {
                        cardsContents.append(CardContent(shape: shape.rawValue, color: color.rawValue, numberOfShapes: num, shading: shade.rawValue))
                    }
                }
            }
        }
        return CardGame(cardsContents)
    }
    
    @Published private var model = createSetGame()
    
    private(set) var highestScore: Double = 0
    
    var cards: [CardGame.Card] {
        model.playingCards
    }
    
    var remainingCards: [CardGame.Card] {
        model.cards
    }
    
    var score: Int {
        return Int(floor(model.score))
    }
    
    var highest: Int {

        if Double(model.score) > Double(highestScore) {
            highestScore = Double(model.score)
            }

        return Int(highestScore)
    }
    
    func cheat() {
        model.cheat()
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
    
    var discardedCards: [CardGame.Card] {
        model.discardedCards
    }
}
