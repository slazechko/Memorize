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
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var theme: MemoryGame<String>.Theme {
        model.theme
    }
    
    
    static func createMemoryGame() -> MemoryGame<String> {
        let theme = getTheme()
        return MemoryGame<String>(theme: theme) { pairIndex in theme.emojis[pairIndex] }
    }
    
    // MARK: - Access to the Model
    static func getTheme() -> MemoryGame<String>.Theme {
        var arrayOfThemes = [MemoryGame<String>.Theme]()
        arrayOfThemes.append(MemoryGame<String>.Theme(name: "halloween", emojis: ["👻", "🎃", "🕷", "👹", "💀",], color: Color.orange, numPairs: 5))
        arrayOfThemes.append(MemoryGame<String>.Theme(name: "food", emojis: ["🍓", "🍆", "🌯","🌮","🍔","🌭"], color: Color.blue))
        arrayOfThemes.append(MemoryGame<String>.Theme(name: "sports", emojis: ["🏓","🏈","⚾️","🏒","🥊","🏁"], color: Color.red))
        return arrayOfThemes.randomElement()!
    }


    
    // MARK: - Intent(s)
    //things the views would say to the ViewModel that they want to happen
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
