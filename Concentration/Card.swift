//
//  Card.swift
//  Concentration
//
//  Created by Алексей Гребенкин on 04.08.2020.
//  Copyright © 2020 Alex Grebenkin. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    func hash(into hasher: inout Card) -> Int {
        return hasher.identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var isViewed = false
    
    private var identifier: Int
    
    
    private static var IdentifierFactory = 0
    
    private static func getUnicIdentifier() -> Int {
        IdentifierFactory += 1
        return IdentifierFactory
    }
    
    init() {
        self.identifier = Card.getUnicIdentifier()
    }
}
