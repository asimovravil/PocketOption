//
//  QuizBrain.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import Foundation

struct QuizBrain {
    
    var questionNumber = 0
    var score = 0
    
    let quiz = [
        Question(q: "How would you describe your attitude towards financial risk?", a: ["a. I prefer low-risk investments with stable returns", "b. I'm comfortable with a moderate level of risk for balanced returns.", "c. I'm open to high-risk investments for the potential of significant returns."], correctAnswer: ""),
        Question(q: "What is your investment goal?", a: ["a. Preserve and protect my capital.", "b. Grow my wealth steadily over time.", "c. Pursue aggressive growth and maximize returns."], correctAnswer: ""),
        Question(q: "How would you react to a sudden drop in the value of your investments?", a: ["a. I would be concerned and consider reevaluating my investment strategy.", "b. I might feel uneasy but would wait for market conditions to improve.", "c. I understand market fluctuations and see it as an opportunity to buy more."], correctAnswer: ""),
        Question(q: "What is your investment time horizon?", a: ["a. Short-term (1-3 years).", "b. Medium-term (3-7 years).", "c. Long-term (7 years or more)."], correctAnswer: ""),
    ]

    mutating func prevQuestion() {
        if questionNumber > 0 {
            questionNumber -= 1
        }
    }

    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    //Need a way of fetching the answer choices.
    func getAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    mutating func getScore() -> Int {
        return score
    }
    
     mutating func nextQuestion() {
        
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        //Need to change answer to rightAnswer here.
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
}
