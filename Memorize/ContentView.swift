//
//  ContentView.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/1/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .font(self.viewModel.cards.count < 5 ? Font.largeTitle : Font.title)
                .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding()
        .foregroundColor(Color.orange)

    }
}

struct CardView: View {
    var card:  MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
    
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
