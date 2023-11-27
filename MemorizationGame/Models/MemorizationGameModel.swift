//
//  MemorizationGameModel.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import Foundation



struct MemorizationGameModel<T> where T: Equatable, T: Hashable {
    private(set) var cards: [Card]


    init(pairOfCards: Int, _ builder: (Int) -> T) {


        var cards: [Card] = []

        for val in 0...pairOfCards {
            let content = builder(val)
            cards.append(
                Card(
                    content: content
                )
            )
            cards.append(
                Card(
                    content: content
                )
            )
        }
        self.cards = cards.shuffled()
    }

    var faceUpCardIndices: Array<Int> {
        cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }
    }


    mutating func chooseCard(_ card: Card) {

        if let targetIndex = cards.firstIndex(where: {
            $0 == card
        }) {

            let targetCard = cards[targetIndex]

            if targetCard.isMatched || targetCard.isFaceUp {
                return
            }


            if faceUpCardIndices.count > 1 {

                cards.indices.forEach { index in cards[index].isFaceUp = false }
                cards[targetIndex].isFaceUp = true
                return
            }

            if faceUpCardIndices.count == 1 {
                // Now we have 2.

                if let existingFaceUpCardIndex = faceUpCardIndices.first {

                    cards[targetIndex].isFaceUp = true

                    if cards[targetIndex].content == cards[existingFaceUpCardIndex].content && cards[targetIndex] != cards[existingFaceUpCardIndex] {

                        cards[targetIndex].isMatched = true
                        cards[existingFaceUpCardIndex].isMatched = true

                    }

                }
                return
            }


            cards[targetIndex].isFaceUp = true
        }
    }



    struct Card: Equatable, Identifiable {
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

    }
}
