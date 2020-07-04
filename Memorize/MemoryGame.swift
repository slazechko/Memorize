//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/3/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable { //This is the model
    //MARK: - Properties
    public var theme: Theme
    var cards: Array<Card>
    
    struct Card:Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false 
        var content: CardContent
        var id: Int
    }
    struct Theme {
        var name: String
        var emojis: Array<String>
        var color: Color?
        var numPairs: Int
        
        init(name: String, emojis: Array<String>, color: Color, numPairs: Int? = nil) {
            self.name = name
            self.emojis = emojis
            self.color = color
            self.numPairs = numPairs ?? Int.random(in: 2..<emojis.count)
        }
    }

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            //if only one card is face up, return it's index. otherwise return nil
            cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            //turn all other cards face down except this one
            //this is like doing something in additon to the SET, we're not actually changing HOW the indexOfTheOneAndOnlyFaceUpCard is set
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    //MARK: - Initializers
    
    init (theme: Theme, cardContentFactory: (Int) -> CardContent){
        self.theme = theme
        self.cards = Array<Card>()
        for pairIndex in 0..<theme.numPairs {
            let content = cardContentFactory(pairIndex)
            self.cards.append(Card(content: content, id: pairIndex*2))
            self.cards.append(Card(content: content, id: pairIndex*2+1))
        }
        self.cards.shuffle()
    }
    
    //MARK: - Functions
    
    mutating func choose(card: Card) { //all functions that modify self in a struct have to be "mutating"
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
}



