//
//  MemoryGame.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import Foundation

struct CardGame {
    
    private(set) var cards: [Card]
    private(set) var playingCards: [Card]
    
    private var indexesOfChosenCards: [Int] {
        get { cards.indices.filter({ cards[$0].isChosen }) }
    }
    
    private var isSet: Bool {
        
        if indexesOfChosenCards.count == 3 {
            
        }
        
        return false
    }
    
    init(_ cardsArray: [CardContent]) {
        cards = []
        playingCards = []
        
        for content in cardsArray {
            cards.append(Card(id: cardsArray.firstIndex(of: content)!*2, content: content))
        }
        cards.shuffle()
        
        for _ in 0..<12 {
            playingCards.append(cards.popLast()!)
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
            playingCards[chosenIndex].isChosen.toggle()
        }
    }
    
    mutating func dealThreeMoreCards () {
        for _ in 0..<3 {
            playingCards.append(cards.popLast()!)
        }
    }
    
    struct Card: Identifiable, Equatable {
        let id: Int
        var isMatched: Bool?
        let content: CardContent
        var isChosen = false
    }
}

struct CardContent: Equatable  {
    var shape: String
    var color: String
    var numberOfShapes: Int
    var shading: String
}
