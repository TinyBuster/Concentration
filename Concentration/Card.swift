//
//  File.swift
//  Concentration
//
//  Created by Jiawen Bai on 1/4/18.
//  Copyright © 2018 Jiawen Bai. All rights reserved.
//

import Foundation

struct Card: Hashable, Equatable
{
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int = 0
    
    private static var identifierFactory = 0
    
    init() {
        Card.identifierFactory += 1
        self.identifier = Card.identifierFactory
    }
}

