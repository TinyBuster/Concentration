//
//  ViewController.swift
//  Concentration
//
//  Created by Jiawen Bai on 1/4/18.
//  Copyright © 2018 Jiawen Bai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var emojiChoices: String = theme[theme.count.arc4random + 1]!
    
    private var theme = [
        1: "😀😃😄😁😆😅😂🤣☺️😊😇🙂🙃😉😌😍😘😗😚😙",
        2: "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐽🐸🐵🙈🙉🙊🐒",
        3: "🍆🥑🥒🍏🍅🥦🍍🍑🥝🍈🥥🍓🍎🍇🍉🍌🍒🍐🍋🍊",
        4: "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥅🏒🏑🏏⛳️🏹🎣🥊🥋🎽",
        5: "🚗🚕🚙🚌🚎🏎🚑🚑🚒🚐🚚🚛🚜🛴🚲🛵🏍🚨🚔🚍",
        6: "🏳️🇦🇮🇦🇺🇦🇬🇦🇺🇦🇹🇦🇲🇦🇿🏴🇦🇶🏁🚩🇧🇸🏳️‍🌈🇩🇿🇦🇷🇦🇩🇦🇸🇦🇴🇦🇽"
    ]
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = theme[theme.count.arc4random + 1]!
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Scores: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = String(emojiChoices.remove(at: emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)))
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}
