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
    private(set) var discardedCards: [Card]
    private(set) var score: Double = 0
    
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
        discardedCards = []
        
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
                score += 3
                discardCards()
                checkEndOfGame()
            } else {
                score -= 1
            }
            
            playingCards.indices.forEach({
                playingCards[$0].isChosen = false
                playingCards[$0].isMatched = nil
                playingCards[$0].isHinted = false
            })
        }
            
        if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
            
            playingCards[chosenIndex].isChosen.toggle()
            
            if indexesOfChosenCards.count == 3 {
                indexesOfChosenCards.forEach({ playingCards[$0].isMatched = isSet })
            }
            
        }
    }
    
    //substitutes one point for each possible set and returns last found set in playing cards
    mutating func cheat (checkEnd: Bool = false) {
        
        if indexesOfChosenCards.count == 3 {
            if isSet {
                score += 3
                discardCards()
                checkEndOfGame()
            } else {
                score -= 1
            }
            
            playingCards.indices.forEach({
                playingCards[$0].isChosen = false
                playingCards[$0].isMatched = nil
                playingCards[$0].isHinted = false
            })
        }
        
        indexesOfChosenCards.reversed().forEach({
            playingCards[$0].isChosen = false
        })
        
        playingCards.forEach { card in
            
            if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
                
                playingCards[chosenIndex].isChosen.toggle()
                
            }
            
            playingCards.filter({ indexesOfChosenCards.contains(playingCards.firstIndex(of: $0)!) == false }).forEach { otherCard in
                
                if let chosenIndex = playingCards.firstIndex(where: { $0.id == otherCard.id }) {
                    
                    playingCards[chosenIndex].isChosen.toggle()
                    
                }
                
                playingCards.filter({ indexesOfChosenCards.contains(playingCards.firstIndex(of: $0)!) == false }).forEach { thirdOtherCard in
                        
                    if let chosenIndex = playingCards.firstIndex(where: { $0.id == thirdOtherCard.id }) {
                        
                        playingCards[chosenIndex].isChosen.toggle()
                        
                    }

                            
                        if indexesOfChosenCards.count == 3 {
                            
                            if isSet {
                                
                                if checkEnd == false {
                                    
                                    playingCards.indices.forEach({
                                        playingCards[$0].isHinted = false
                                    })
                                    
                                    score -= 1 / 6
                                    //discardCards()
                                }
                                
                                indexesOfChosenCards.reversed().forEach({
                                    playingCards[$0].isHinted = true
                                    playingCards[$0].isChosen = false
                                    playingCards[$0].isMatched = nil
                                    
                                })
                                
                                return
                            }
                            
                            indexesOfChosenCards.reversed().forEach({
                                playingCards[$0].isChosen = false
                            })
                            
                            if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
                                
                                playingCards[chosenIndex].isChosen.toggle()
                                
                            }
                            
                            if let chosenIndex = playingCards.firstIndex(where: { $0.id == otherCard.id }) {
                                
                                playingCards[chosenIndex].isChosen.toggle()
                                
                            }
                            
                            
                        }
                        
                        
                }

                
                indexesOfChosenCards.reversed().forEach({
                    playingCards[$0].isChosen = false
                    
                    if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
                        
                        playingCards[chosenIndex].isChosen.toggle()
                        
                    }
                    
                })
                
                
            }
            
            indexesOfChosenCards.reversed().forEach({
                playingCards[$0].isChosen = false
            })
            
            
        }
        
    }
    
    
    // substitutes 3 points for every possible set in currently displayed cards
    mutating func checkSet () {
        
        var indexesOfChosenCardsCheck: [Int] = []
        
        for card in playingCards {
            
            indexesOfChosenCardsCheck.append(playingCards.firstIndex(of: card)!)
            
            for otherCard in playingCards.filter({ indexesOfChosenCardsCheck.contains(playingCards.firstIndex(of: $0)!) == false }) {
                
                indexesOfChosenCardsCheck.append(playingCards.firstIndex(of: otherCard)!)
                
                for thirdCard in playingCards.filter({ indexesOfChosenCardsCheck.contains(playingCards.firstIndex(of: $0)!) == false }) {
                    
                    indexesOfChosenCardsCheck.append(playingCards.firstIndex(of: thirdCard)!)
                    
                    if indexesOfChosenCardsCheck.count == 3 {
                        
                        let card1 = playingCards[indexesOfChosenCardsCheck[0]].content
                        let card2 = playingCards[indexesOfChosenCardsCheck[1]].content
                        let card3 = playingCards[indexesOfChosenCardsCheck[2]].content
                        
                        let checkShape = (card1.shape == card2.shape && card2.shape == card3.shape && card1.shape == card3.shape) || (card1.shape != card2.shape && card2.shape != card3.shape && card1.shape != card3.shape)
                        let checkColor = (card1.color == card2.color && card2.color == card3.color && card1.color == card3.color) || (card1.color != card2.color && card2.color != card3.color && card1.color != card3.color)
                        let checkNumberOfShapes = (card1.numberOfShapes == card2.numberOfShapes && card2.numberOfShapes == card3.numberOfShapes && card1.numberOfShapes == card3.numberOfShapes) || (card1.numberOfShapes != card2.numberOfShapes && card2.numberOfShapes != card3.numberOfShapes && card1.numberOfShapes != card3.numberOfShapes)
                        let checkShading = (card1.shading == card2.shading && card2.shading == card3.shading && card1.shading == card3.shading) || (card1.shading != card2.shading && card2.shading != card3.shading && card1.shading != card3.shading)
                        
                        if checkShape && checkColor && checkNumberOfShapes && checkShading == true {
                            //divide by 6 as sets can repeat themselves in algorithm 6 times
                            score -= 3 / 6
                        }
                        
                        indexesOfChosenCardsCheck = []
                        indexesOfChosenCardsCheck.append(playingCards.firstIndex(of: card)!)
                        indexesOfChosenCardsCheck.append(playingCards.firstIndex(of: otherCard)!)

                    }
                    
                }
                
                indexesOfChosenCardsCheck = []
                indexesOfChosenCardsCheck.append(playingCards.firstIndex(of: card)!)
                
            }
            
            indexesOfChosenCardsCheck = []
            
        }
        
    }
    
    mutating func checkEndOfGame () {

        if cards.isEmpty {
            //use cheat to check if there are no more sets in the game and finish the game
            cheat(checkEnd: true)
            if playingCards.filter({$0.isHinted == true}).count == 0 {
                playingCards = []
            }
            playingCards.indices.forEach({
                playingCards[$0].isHinted = false
            })
            
        }
    }
    
    mutating func addCards() {
        indexesOfChosenCards.reversed().forEach({
            playingCards[$0].isChosen = false
            playingCards[$0].isMatched = nil
            playingCards[$0].isHinted = false
            discardedCards.append(playingCards[$0])
            playingCards.remove(at: $0)
            if !cards.isEmpty {
                playingCards.insert(cards.popLast()!, at: $0)
            }
        })
    }
    
    private mutating func discardCards() {
        indexesOfChosenCards.reversed().forEach({
            playingCards[$0].isHinted = false
            playingCards[$0].isChosen = false
            playingCards[$0].isMatched = nil
            discardedCards.append(playingCards[$0])
            playingCards.remove(at: $0)
        })
    }
    
    mutating func dealThreeMoreCards () {
        
        if playingCards.count < 21 {
            
            if isSet {
                score += 3
                addCards()
                checkEndOfGame()
                return
            } else {
                //Substitute 3 points for every possible set from currently displayed cards
                checkSet()
            }
            
            for _ in 0..<3 {
                playingCards.append(cards.popLast()!)
            }
            
            checkEndOfGame()
            
        }
        
    }
    
    struct Card: Identifiable, Equatable {
        let id: Int
        var isMatched: Bool?
        let content: CardContent
        var isChosen = false
        var isHinted = false
    }
}
