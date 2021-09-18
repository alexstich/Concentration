//
//  ViewController.swift
//  Concentration
//
//  Created by Алексей Гребенкин on 04.08.2020.
//  Copyright © 2020 Alex Grebenkin. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController
{
    // MARK: Settings
    
    private var game = Concentration()
    private var colorTheme = ColorTheme() {
        didSet {
            self.view.backgroundColor = colorTheme.backgroundColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChosenTheme()
        titleLabel.text = emojiTheme.emojiSetName
    }
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter {
            !$0.superview!.isHidden
        }
    }

    
    // MARK: Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var changeThemeButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    
    // MARK: Actions
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        if let cardNumber = visibleCardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        resetSettings()
        updateViewFromModel()
    }
    
    @IBAction func changeTheme(_ sender: UIButton) {
        self.colorTheme = ColorTheme(after: colorTheme.themeIndex)
        self.setChosenTheme()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    // MARK: Other funcs
    
    private func resetSettings() {
        game = Concentration()
        emojiTheme = EmojiTheme()
        emoji = [Card: String]()
        titleLabel.text = emojiTheme.emojiSetName
    }
    
    private func updateViewFromModel() {
        guard visibleCardButtons != nil else { return }
        for index in visibleCardButtons.indices {
            let button = visibleCardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp && !card.isMatched{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = colorTheme.backgroundColor
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0) : colorTheme.shirtCardColor
            }
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func setChosenTheme() {
        
        changeThemeButton.backgroundColor = colorTheme.shirtCardColor
        newGameButton.backgroundColor = colorTheme.shirtCardColor
        
        self.view.backgroundColor = colorTheme.backgroundColor
        self.view.tintColor = colorTheme.shirtCardColor
        
        for index in 0..<(Concentration.maxNumberPairsCards * 2) {
            let button = visibleCardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.backgroundColor = colorTheme.backgroundColor
            } else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0) : colorTheme.shirtCardColor
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiTheme = EmojiTheme()
            emojiTheme.emojiSetName = theme!
            emoji = [Card: String]()
            if titleLabel != nil {
                titleLabel.text = theme!
            }
            updateViewFromModel()
        }
    }
    
    private var emojiTheme = EmojiTheme()
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiTheme.emojiSet.count > 0 {
            emoji[card] = emojiTheme.emojiSet.remove(at: emojiTheme.emojiSet.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
