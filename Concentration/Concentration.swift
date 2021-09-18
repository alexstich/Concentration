//
//  Concentration.swift
//  Concentration
//
//  Created by Алексей Гребенкин on 04.08.2020.
//  Copyright © 2020 Alex Grebenkin. All rights reserved.
//

import Foundation

struct Concentration {
    
    private (set) var cards = [Card]()
    var flipCount = 0
    var score = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    static let maxNumberPairsCards = 10
    
    init(numbersOfPairsOfCards: Int? = nil) {
        
        let pairs: Int
        if numbersOfPairsOfCards == nil || numbersOfPairsOfCards! > Concentration.maxNumberPairsCards {
            pairs = Concentration.maxNumberPairsCards
        } else {
            pairs = numbersOfPairsOfCards!
        }
        
        for _ in 1...pairs {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concetration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].isViewed {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        cards[index].isViewed = true
        flipCount += 1
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
