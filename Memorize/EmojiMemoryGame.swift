//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/3/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject { //this is the view model
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame() //@Published > everytime this var changes, it calls the objectWillChange.send()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷", "👹", "💀", "🍓", "🍆", "🌯", "🐕", "🎮", "⛳️", "👑", "👏"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in emojis[pairIndex] }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    //things the views would say to the ViewModel that they want to happen
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
