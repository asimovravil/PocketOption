//
//  Question.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import Foundation

struct Binance {
    let text: String
    
    let answers: [String]
    let rightAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answers = a
        rightAnswer = correctAnswer
    }
}
