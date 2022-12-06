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
            
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                        
                    }
                    
                }
                
            }
            .padding(.horizontal)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetCardGame()
        SetGameView(game: game)
    }
}

struct CardView: View {
    
    let card: CardGame.Card
    
    var cardColor: Color {
        switch card.content.color {
        case "red":
            return .red
        case "green":
            return .green
        case "violet":
            return .purple
        default:
            return .red
        }
    }
    
    var body: some View {
        
        ZStack {
            
            let shape = RoundedRectangle(cornerRadius: 10)
            
            shape
                .fill()
                .foregroundColor(.white)
            shape
                .strokeBorder(lineWidth: 3)
                .foregroundColor(.red)
            VStack {
                if card.content.shape == "O" {
                    if card.content.shading == "hollow" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("Hollow")
                        }
                    }
                    if card.content.shading == "full" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("full")
                        }
                    }
                    if card.content.shading == "striped" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("striped")
                        }
                    }
                    
                }
                if card.content.shape == "S" {
                    if card.content.shading == "hollow" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("Hollow")
                        }
                    }
                    if card.content.shading == "full" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("full")
                        }
                    }
                    if card.content.shading == "striped" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("striped")
                        }
                    }
                }
                if card.content.shape == "D" {
                    if card.content.shading == "hollow" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("Hollow")
                        }
                    }
                    if card.content.shading == "full" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("full")
                        }
                    }
                    if card.content.shading == "striped" {
                        ForEach(0..<card.content.numberOfShapes, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 40, height: 20)
                                .foregroundColor(cardColor)
                            Text("striped")
                        }
                    }
                }
            }
        }
    }
}
