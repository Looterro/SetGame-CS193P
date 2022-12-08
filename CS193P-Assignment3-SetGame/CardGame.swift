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
        get { playingCards.indices.filter({ playingCards[$0].isChosen }) }
    }
    
    private var isSet: Bool {
        
        if indexesOfChosenCards.count == 3 {
            let card1 = playingCards[indexesOfChosenCards[0]].content
            let card2 = playingCards[indexesOfChosenCards[1]].content
            let card3 = playingCards[indexesOfChosenCards[2]].content
            
            let checkShape = (card1.shape == card2.shape && card2.shape == card3.shape && card1.shape == card3.shape) || (card1.shape != card2.shape && card2.shape != card3.shape && card1.shape != card3.shape)
            let checkColor = (card1.color == card2.color && card2.color == card3.color && card1.color == card3.color) || (card1.color != card2.color && card2.color != card3.color && card1.color != card3.color)
            let checkNumberOfShapes = (card1.numberOfShapes == card2.numberOfShapes && card2.numberOfShapes == card3.numberOfShapes && card1.numberOfShapes == card3.numberOfShapes) || (card1.numberOfShapes != card2.numberOfShapes && card2.numberOfShapes != card3.numberOfShapes && card1.numberOfShapes != card3.numberOfShapes)
            let checkShading = (card1.shading == card2.shading && card2.shading == card3.shading && card1.shading == card3.shading) || (card1.shading != card2.shading && card2.shading != card3.shading && card1.shading != card3.shading)
            
            return checkShape && checkColor && checkNumberOfShapes && checkShading
            
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
        
        if indexesOfChosenCards.count == 3 {
            if isSet {
                addCards()
            }
            playingCards.indices.forEach({
                playingCards[$0].isChosen = false
                playingCards[$0].isMatched = nil
            })
        }
            
        if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
            
            playingCards[chosenIndex].isChosen.toggle()
            
            if indexesOfChosenCards.count == 3 {
                indexesOfChosenCards.forEach({ playingCards[$0].isMatched = isSet })
            }
            
        }
    }
    
    mutating func addCards() {
        indexesOfChosenCards.reversed().forEach({
            playingCards.remove(at: $0)
            if !cards.isEmpty {
                playingCards.insert(cards.popLast()!, at: $0)
            }
        })
    }
    
    mutating func dealThreeMoreCards () {
        
        if isSet {
            addCards()
            return
        }

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
