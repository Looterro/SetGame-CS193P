//
//  MemoryGame.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import Foundation

struct CardGame {
    
    private(set) var cards: [Card]
    
    init(_ testArray: [CardContentTest]) {
        cards = [Card]()
        
        for content in testArray {
            cards.append(Card(id: testArray.firstIndex(of: content)!, content: content))
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        var isMatched = false
        let content: CardContentTest
        var seen = false
    }
}
