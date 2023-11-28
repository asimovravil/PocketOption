//
//  QuizTestTableViewCell.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import UIKit

final class QuizTestTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: QuizTestTableViewCell.self)
    var quizBrain = QuizBrain()
    private var answerSelected = false
    var userCorrectAnswers = 0
    weak var navigationController: UINavigationController?
    
    // MARK: - UI
    
    let questionLabel = UILabel()
    let firstAnswerButton = UIButton()
    let secondAnswerButton = UIButton()
    let thirdAnswerButton = UIButton()
    let countLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        questionLabel.textColor = .white
        questionLabel.font = UIFont(name: "NunitoSans-Bold", size: 24)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionLabel)
        
        firstAnswerButton.setTitle("1 answer", for: .normal)
        firstAnswerButton.setTitleColor(.white, for: .normal)
        firstAnswerButton.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        firstAnswerButton.contentHorizontalAlignment = .center
        firstAnswerButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        firstAnswerButton.layer.cornerRadius = 10
        firstAnswerButton.backgroundColor = AppColor.quizColor.uiColor
        firstAnswerButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(firstAnswerButton)
        
        secondAnswerButton.setTitle("2 answer", for: .normal)
        secondAnswerButton.setTitleColor(.white, for: .normal)
        secondAnswerButton.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        secondAnswerButton.contentHorizontalAlignment = .center
        secondAnswerButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        secondAnswerButton.layer.cornerRadius = 10
        secondAnswerButton.backgroundColor = AppColor.quizColor.uiColor
        secondAnswerButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondAnswerButton)
        
        thirdAnswerButton.setTitle("3 answer", for: .normal)
        thirdAnswerButton.setTitleColor(.white, for: .normal)
        thirdAnswerButton.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        thirdAnswerButton.contentHorizontalAlignment = .center
        thirdAnswerButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        thirdAnswerButton.layer.cornerRadius = 10
        thirdAnswerButton.backgroundColor = AppColor.quizColor.uiColor
        thirdAnswerButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thirdAnswerButton)
        
        countLabel.text = "1/4"
        countLabel.textColor = .blue
        countLabel.font = UIFont(name: "NunitoSans-Regular", size: 16)
        countLabel.numberOfLines = 0
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            countLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 12),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            firstAnswerButton.bottomAnchor.constraint(equalTo: secondAnswerButton.topAnchor, constant: -16),
            firstAnswerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            firstAnswerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            firstAnswerButton.heightAnchor.constraint(equalToConstant: 84),
            
            secondAnswerButton.bottomAnchor.constraint(equalTo: thirdAnswerButton.topAnchor, constant: -16),
            secondAnswerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            secondAnswerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            secondAnswerButton.heightAnchor.constraint(equalToConstant: 84),
            
            thirdAnswerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thirdAnswerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thirdAnswerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            thirdAnswerButton.heightAnchor.constraint(equalToConstant: 84),
            
        ])
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func quitQuizButtonTapped() {
        if quizBrain.questionNumber > 0 {
            quizBrain.prevQuestion()
            updateUI()
        }
    }
    
    @objc private func nextQuizButtonTapped() {
        quizBrain.nextQuestion()
        
        if quizBrain.questionNumber == 0 {
            showResultViewController()
        } else {
            updateUI()
        }
    }
    
    @objc public func updateUI() {
        let questionText = quizBrain.getQuestionText()
        let answers = quizBrain.getAnswers()
        
        questionLabel.text = questionText
        firstAnswerButton.setTitle(answers[0], for: .normal)
        secondAnswerButton.setTitle(answers[1], for: .normal)
        thirdAnswerButton.setTitle(answers[2], for: .normal)
        
        countLabel.text = "\(quizBrain.questionNumber + 1)/\(quizBrain.quiz.count)"
        
        answerSelected = false
    }
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        if !answerSelected {
            let userAnswer = sender.currentTitle!
            let userGotItRight = quizBrain.checkAnswer(userAnswer: userAnswer)

            if userGotItRight {
                sender.backgroundColor = AppColor.quizColor.uiColor
                userCorrectAnswers += 1
            } else {
                sender.backgroundColor = AppColor.quizColor.uiColor
            }
            
            sender.layer.cornerRadius = 10
            answerSelected = true
            quizBrain.nextQuestion()
            updateUI()
            answerSelected = false
        }
    }
    
    private func showResultViewController() {
        if userCorrectAnswers == 4 {

        } else {

        }
    }
}

