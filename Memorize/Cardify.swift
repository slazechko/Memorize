//
//  Cardify.swift
//  Memorize
//
//  Created by Sam Lazechko on 7/5/20.
//  Copyright © 2020 Sam Lazechko. All rights reserved.
//

import SwiftUI

///Modify any content by turning it into a "card" (IE, the content is placed onto a card w/ a front and back)
struct Cardify: ViewModifier  {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                 RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
