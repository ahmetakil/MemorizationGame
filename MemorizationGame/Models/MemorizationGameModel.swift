//
//  MemorizationGameModel.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import Foundation



struct MemorizationGameModel<T> where T: Equatable {
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
        cards.indices.filter { cards[$0].isFaceUp }
    }

    var faceUpCardIndex: Int? {

        get {
            cards.indices.filter { index in cards[index].isFaceUp }.first
        }

        set {
            cards.indices.forEach { index in
                cards[index].isFaceUp = (index == newValue)
            }
        }

    }

    mutating func chooseCard(_ card: Card) {
        print("Will rotate card: \(card)")

        if let targetIndex = cards.firstIndex(where: {
            $0 == card
        }) {

            let targetCard = cards[targetIndex]

            if targetCard.isMatched {
                return
            }


            if targetCard.isFaceUp {
                cards[targetIndex].isFaceUp = false
                return
            }




            if faceUpCardIndices.count > 1 {

                faceUpCardIndex = targetIndex

            }

            if let facingUpCardIndex = faceUpCardIndex {


                if targetCard.content == cards[facingUpCardIndex].content {

                    // Match!.
                    cards[targetIndex].isMatched = true
                    cards[facingUpCardIndex].isMatched = true

                    cards[targetIndex].isFaceUp = false
                    cards[facingUpCardIndex].isMatched = false

                }


            } else {

                // Turn the 2 cards back down.
                faceUpCardIndex = targetIndex

            }

            cards[targetIndex].isFaceUp = true


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
