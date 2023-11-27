//
//  MemorizationGameCard.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import SwiftUI


struct CardView: View {


    let card: Card

    init(_ card: Card) {

        self.card = card
    }

    var body: some View {

        if(card.isMatched) {
            Color.clear
                .transition(.scale)
        } else {
            ZStack {

                let base = RoundedRectangle(cornerRadius: 12.0)
                base.strokeBorder(lineWidth: 2.0)
                    .background(base.fill(.white))
                    .overlay(
                    Text(card.content)
                        .font(.system(size: 60)))
                    .opacity(card.isFaceUp ? 1 : 0)
                base.fill()
                    .opacity(card.isFaceUp ? 0 : 1)

            }
                .aspectRatio(3 / 4, contentMode: .fit)
                .rotation3DEffect(.degrees(card.isFaceUp ? 0 : 180), axis: (0, 1, 0))
                .foregroundColor(.orange)
        }
    }
}



#Preview {
    VStack {
        HStack {
            CardView(Card(content: "🐁"))
            CardView(Card(content: "🐁", isFaceUp: true))
        }
        HStack {
            CardView(Card(content: "🐁", isMatched: true))
            CardView(Card(content: "🌝", isFaceUp: true))
        }
    }.padding()
}
