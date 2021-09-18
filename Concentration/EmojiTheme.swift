//
//  Theme.swift
//  Concentration
//
//  Created by Алексей Гребенкин on 04.08.2020.
//  Copyright © 2020 Alex Grebenkin. All rights reserved.
//

import Foundation

struct EmojiTheme
{
    var emojiSet: [String]
    var emojiSetName: String {
        didSet{
            if EmojiTheme.themeTitles(rawValue: emojiSetName) == nil {
                emojiSetName = EmojiTheme.themeTitles.Animals.rawValue
            }
            emojiSet = EmojiTheme.emojis[emojiSetName]!
        }
    }
    
    static let emojis: [String: [String]] = [
        "Animals": ["🦕", "🐢", "🦞", "🐬", "🐅", "🦧", "🦒", "🐖", "🐏", "🐓", "🦢", "🐇"],
        "Flowers": ["☘️", "🌳", "🌿", "🌲", "🌵", "🍁", "🥀", "🌸", "🌻", "🍄", "💐", "🌼"],
        "Food":    ["🍎", "🍐", "🍋", "🍊", "🍌", "🍉", "🍇", "🍓", "🥭", "🍒", "🥥", "🍆"],
        "Activity":["⚽️", "🏀", "🏈", "🥎", "🎱", "🏓", "🥏", "🥊", "🏹", "🥋", "⛸", "🛹"],
        "Cars":    ["🚗", "🚕", "🚙", "🏎", "🚑", "🚓", "🚚", "🛴", "🚜", "🛵", "🏍", "🛺"],
        "Stuff":   ["🛢", "💸", "⚖️", "💎", "🧱", "🧲", "🔫", "🏺", "🔬", "💊", "🦠", "🛁"]
    ]
    
    enum themeTitles: String {
        case Animals
        case Flowers
        case Food
        case Activity
        case Cars
        case Stuff
    }
    
    init() {
        (self.emojiSetName, self.emojiSet) = EmojiTheme.emojis.randomElement()!
    }
}
