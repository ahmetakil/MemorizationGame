//
//  MemorizationGameViewModel.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import Foundation

typealias Card = MemorizationGameModel<String>.Card

class MemorizationGameViewModel: ObservableObject {

    @Published private var gameModel: MemorizationGameModel<String>


    static var _pairOfCards = 4
    static var pairOfCards: Int {
        get {
            _pairOfCards
        }
        set {

            if(newValue < 0 || newValue > MAX_CARD_COUNT) {
                return
            }

            _pairOfCards = newValue
        }
    }


    static let emojis = "⌚️📱💰🔫🍐🍓🪣🔑🎈🩸🌯🍙🌎✂️📫🌎"
    static var MAX_CARD_COUNT: Int {
        emojis.count
    }


    private var facedUpCard: Card?


    init() {
        gameModel = MemorizationGameViewModel.createGame()
    }

    private static func createGame() -> MemorizationGameModel<String> {
        let shuffledList = emojis.split(separator: "").shuffled()

        return MemorizationGameModel(pairOfCards: MemorizationGameViewModel.pairOfCards) { index in
            String(shuffledList[index])
        }
    }

    var cards: Array<Card> {
        gameModel.cards
    }

    private func restartGame() {
        gameModel = MemorizationGameViewModel.createGame()
    }
    
    // MARK: - Intents

    func rotateCard(_ card: Card) {
        gameModel.chooseCard(card)
    }

    func incrementCards() {
        MemorizationGameViewModel.pairOfCards += 1
        restartGame()
    }

    func decrementCards() {
        MemorizationGameViewModel.pairOfCards -= 1
        restartGame()
    }



    
}
