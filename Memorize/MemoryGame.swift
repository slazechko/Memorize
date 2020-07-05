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
    var cards: Array<Card>
    var score: Int
    
    struct Card:Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false 
        var content: CardContent
        var previouslySeen: Bool = false
        var id: Int
        
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
    
    init (numPairs: Int, cardContentFactory: (Int) -> CardContent){
        self.score = 0
        self.cards = Array<Card>()
        for pairIndex in 0..<numPairs {
            let content = cardContentFactory(pairIndex)
            self.cards.append(Card(content: content, id: pairIndex*2))
            self.cards.append(Card(content: content, id: pairIndex*2+1))
        }
        self.cards.shuffle()
    }
    
    //MARK: - Functions
    
    mutating func choose(card: Card) { //all functions that modify self in a struct have to be "mutating"
//        print("card chosen: \(card)")
        if let   chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard { //we only get past this if there is one and only one card up.
                if cards[chosenIndex].content == cards[potentialMatchIndex].content { //if we have a match
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    self.score = self.score + 2 //plus 2 points for a match
                } else {
                    let penalty1: Int = cards[chosenIndex].previouslySeen ? 1 : 0
                    let penalty2: Int = cards[potentialMatchIndex].previouslySeen ? 1 : 0
                    score = score - penalty1 - penalty2
                    if (!cards[chosenIndex].previouslySeen) { cards[chosenIndex].previouslySeen = true }
                    if (!cards[potentialMatchIndex].previouslySeen) { cards[potentialMatchIndex].previouslySeen = true }
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
}



