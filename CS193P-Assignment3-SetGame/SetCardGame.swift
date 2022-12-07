//
//  SetMemoryGame.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import Foundation
import SwiftUI

class SetCardGame: ObservableObject {
    
    private static let shapes = ["diamond", "sguiggle", "oval"] // shapes will come with stripes or not, so 3 shapes x 3 different fillings
    private static let shading = ["hollow", "full", "striped"]
    private static let colors = ["red", "green", "violet"]
    private static var cardArrayTest: [CardContentTest] = []
    
    private static func createSetGame() -> CardGame {
        
        for color in colors {
            for shape in shapes {
                for shade in shading {
                    for num in 1...3 {
                        cardArrayTest.append(CardContentTest(shape: shape, color: color, numberOfShapes: num, shading: shade))
                    }
                }
            }
        }
        print(cardArrayTest.count)
        return CardGame(cardArrayTest)
    }
    
    @Published private var model = createSetGame()
    
    var cards: [CardGame.Card] {
        model.cards
    }
}

struct CardContentTest: Equatable  {
    var shape: String
    var color: String
    var numberOfShapes: Int
    var shading: String
}
