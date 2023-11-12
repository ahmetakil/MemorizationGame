//
//  MemorizationGameViewModel.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import Foundation

typealias Card = MemorizationGameModel<String>.Card

class MemorizationGameViewModel: ObservableObject {
    
    @Published private var gameModel : MemorizationGameModel<String>
    let pairOfCards = 4
    

    let emojis = "⌚️📱💰🔫🍐🍓🪣🔑🎈🩸🌯🍙🌎✂️📫"

    
    init() {
        let shuffledList = emojis.split(separator: "").shuffled().prefix(upTo: pairOfCards)
       
        var cards: [Card] = []
        
        for shuffledElement in shuffledList {
            cards.append(
                Card(
                    content: String(shuffledElement)
                    )
            )
            cards.append(
                Card(
                    content: String(shuffledElement)
                    )
            )
        }
        self.gameModel = MemorizationGameModel(cards: cards.shuffled())
    }
    
    var cards: Array<Card>{
        print("Returning cards !")
        return self.gameModel.cards
    }
    
    
    // MARK - Intents
    
    func rotateCard(_ card: Card) {
    
        self.gameModel.rotateCard(card)
    }
}
