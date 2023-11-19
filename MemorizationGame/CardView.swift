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
        
        if card.isMatched {
            
            Color.clear
            
        } else {
            

            ZStack {
                let base = RoundedRectangle(cornerRadius: 12.0)
                base.strokeBorder(lineWidth: 2)
                    .background(base.fill(.white))
                    .overlay(
                        Text(card.content)
                            .font(.system(size: 60))
                    )
                    .opacity(card.isFaceUp ? 1 : 0.2)
                base.fill(card.isFaceUp ? .green : .orange)
                    .opacity(card.isFaceUp ? 0: 1)
            }
            .aspectRatio(3/4, contentMode: .fit)
        }
        
        
    }
}

#Preview {
    VStack {
        HStack {
            CardView(Card(content: "🐁"))
            CardView(Card(content: "🐁",isFaceUp: true))
        }
        HStack{
            CardView(Card(content: "🐁",isMatched: true))
            CardView(Card(content: "🌝",isFaceUp: true))
        }
    }.padding()
}
