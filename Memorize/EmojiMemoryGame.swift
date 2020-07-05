//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/3/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import SwiftUI
import UIKit

class EmojiMemoryGame: ObservableObject { //this is the view model
    @Published private var model: MemoryGame<String> //@Published > everytime this var changes, it calls the objectWillChange.send()
    var theme: Theme
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var score: Int {
        model.score
    }

    init() {
        let pickedTheme = Theme.getRandomTheme()
        self.theme = pickedTheme
        self.model = MemoryGame<String>(numPairs: Int.random(in: 2..<pickedTheme.emojis.count)) { pairIndex in pickedTheme.emojis[pairIndex] }
    }
    
//    static func createMemoryGame() -> MemoryGame<String> {
//        return MemoryGame<String>(numPairs: Int.random(in: 2..<theme.emojis.count)) { pairIndex in theme.emojis[pairIndex] }
//    }
        
    ///theme  definition
    enum Theme: CaseIterable {
        case halloween, food, sports
        
        var name: String {
            switch self {
            case .halloween:
                return "Halloween"
            case .food:
                return "Food"
            case .sports:
                return "Sports"
            }
        }
        
        var color: Color {
            switch self {
            case .halloween:
                return Color.orange
            case .food:
                return Color.blue
            case .sports:
                return Color.red
            }
        }
        
        var emojis: Array<String> {
            switch self {
            case .halloween:
                return ["👻", "🎃", "🕷", "👹", "💀",]
            case .food:
                return ["🍓", "🍆", "🌯","🌮","🍔","🌭"]
            case .sports:
                return ["🏓","🏈","⚾️","🏒","🥊","🏁"]
            }
        }
        
//        //num of possible themes
//        static var count: Int {
//            return self.count
//        }
        
        static func getRandomTheme() -> Theme {
            return self.allCases.randomElement()!
        }
    }


    // MARK: - Intent(s)
    //things the views would say to the ViewModel that they want to happen
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    // This isn't great since it basically just repeats the initializer
    func startNewGame() {
        self.theme = Theme.getRandomTheme()
        self.model = MemoryGame<String>(numPairs: Int.random(in: 2..<theme.emojis.count)) { pairIndex in theme.emojis[pairIndex] }
    }
}
