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

    //my code will never call this, it is called by the system.
    var body: some View {
        VStack {
            Text(viewModel.theme.name)
            .padding()
            .font(.title)
            Text("Score: \(viewModel.score)")
            .padding()
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
//              .aspectRatio(2/3, contentMode: .fit)
                .padding()
            }
            .foregroundColor(viewModel.theme.color)
            Button(action: {
                self.viewModel.startNewGame()
            }) {
                Text("New Game")
            }
            .padding()
        }
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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-330), clockwise: true).padding(5).opacity(0.5)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
}
    
// MARK: - Drawing Constants
private func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.6
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
