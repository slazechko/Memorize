//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/3/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> { //This is the model
    var cards: Array<Card>
    
    mutating func choose(card: Card) { //all functions that modify self in a struct have to be "mutating"
        print("card chosen: \(card)")
        let chosenIndex: Int = index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    func index(of inpCard: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == inpCard.id {
                return index
            }
        }
        return -1 //TODO: bogus return if index not found! 
    }
    
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card:Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
