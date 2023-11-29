//
//  MemorizationGameViewModel.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import Foundation

typealias Card = MemorizationGameModel<String>.Card
let initialPairOfCards = 4

 

class MemorizationGameViewModel: ObservableObject {

    @Published private var gameModel: MemorizationGameModel<String> {
        didSet {
            let isGameCompleted = gameModel.cards.allSatisfy {
                $0.isMatched
            }
            
            if(isGameCompleted){
                isGameOver = true
                allTimeHigh = score
            }
        }
    }
    
    var allTimeHigh: Int {
        get {
            UserDefaults.standard.integer(forKey: userDefaultsMaxScoreKey)
        }
        set {
            
            if newValue > allTimeHigh {
                
                UserDefaults.standard.setValue(newValue, forKey: userDefaultsMaxScoreKey)
                reachedAllTimeHigh = true
            }
            
        }
    }
    
    var reachedAllTimeHigh: Bool = false
    

    static var _pairOfCards = initialPairOfCards
    static var pairOfCards: Int {
        get {
            _pairOfCards
        }
        set {

            if(newValue < 0 || newValue >= MAX_CARD_COUNT) {
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
    
    var isGameOver: Bool = false

    var cards: Array<Card> {
        gameModel.cards
        
    }
    
    var movesCount: Int = 0
    
    var score: Int {
        gameModel.score
    }

    // MARK: - Intents

    
    func restartGame(resetPairOfCardsCount: Bool? = nil) {
        
        if(resetPairOfCardsCount != nil){
            MemorizationGameViewModel.pairOfCards = initialPairOfCards
        }
        
        movesCount = 0
        gameModel = MemorizationGameViewModel.createGame()
    }
    

    func rotateCard(_ card: Card) {
        gameModel.chooseCard(card)
        movesCount += 1
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


let userDefaultsMaxScoreKey = "userDefaultsMaxScoreKey"
