//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/1/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import SwiftUI

//MARK: - Views

/// Main view.
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame //@ObservedObject the other side of @Published, this is what makes view update when the model changes
    
    var body: some View { //my code will never call this, it is called by the system.
        Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
//                .aspectRatio(2/3, contentMode: .fit)
                .padding()
            }
            .foregroundColor(Color.orange)
    }
}

/// Sub View for individual cards.
struct CardView: View {
    var card:  MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                     RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}





//MARK: - Ignore (For Now)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
