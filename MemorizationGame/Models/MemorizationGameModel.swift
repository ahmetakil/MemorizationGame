//
//  MemorizationGameModel.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import Foundation

struct MemorizationGameModel<T> where T: Equatable{
    private(set) var cards: [Card]

    init(cards: [Card]) {
        self.cards = cards
    }

    mutating func rotateCard(_ card: Card) {
        print("Will rotate card: \(card)")

        if let index = cards.firstIndex(where: {
            $0 == card
        }) {
            cards[index].isFaceUp.toggle()
            print("Toggled card: \(cards[index])")
        }
    }

    struct Card: Equatable, Identifiable, Hashable {
        var content: T
        var isFaceUp: Bool
        var isMatched: Bool
        let id: UUID

        init(content: T, isFaceUp: Bool = false, isMatched: Bool = false) {
            self.content = content
            id = UUID()
            self.isFaceUp = isFaceUp
            self.isMatched = isMatched
        }

        static func == (lhs: MemorizationGameModel<T>.Card, rhs: MemorizationGameModel<T>.Card) -> Bool {
            lhs.id == rhs.id && lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
