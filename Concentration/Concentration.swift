//
//  Concentration.swift
//  Concentration
//
//  Created by Jiawen Bai on 1/4/18.
//  Copyright © 2018 Jiawen Bai. All rights reserved.
//

import Foundation

struct Concentration
{
    
    private(set)  var cards = [Card]()
    
    private(set) var flipCount = 0
    
    private(set) var score = 0
    
    private(set) var shownCardIndexs = [Int]()
    
    private(set) var time = Date()
    private(set) var lastTime = Date()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        time = Date()
        flipCount += 1
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index] == cards[matchIndex] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    if time.timeIntervalSince(lastTime) < 0.8 {
                        score += 6
                    } else if time.timeIntervalSince(lastTime) < 1.6 {
                        score += 4
                    } else {
                        score += 2
                    }
                } else {
                    if shownCardIndexs.contains(index) {
                        score -= 1
                    }
                    if shownCardIndexs.contains(index) && shownCardIndexs.contains(matchIndex) {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                lastTime = Date()
            }
        }
        if !shownCardIndexs.contains(index) {
            shownCardIndexs.append(index)
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you muat have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        for index in cards.indices {
            let randomIndex = cards.count.arc4random
            if randomIndex != index {
                cards.swapAt(randomIndex, index)
            }
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
