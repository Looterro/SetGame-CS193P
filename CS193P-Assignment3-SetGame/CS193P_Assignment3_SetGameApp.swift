//
//  CS193P_Assignment3_SetGameApp.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 05/12/2022.
//

import SwiftUI

@main
struct CS193P_Assignment3_SetGameApp: App {
    private let game = SetCardGame()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game : game)
        }
    }
}
