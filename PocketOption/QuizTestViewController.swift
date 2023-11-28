//
//  QuizTestViewController.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import UIKit

final class QuizTestViewController: UIViewController {
    
    let quizBack = UIImageView()
    let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        
        quizBack.image = UIImage(named: "quizImage")
        quizBack.layer.masksToBounds = true
        quizBack.contentMode = .scaleAspectFit
        quizBack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizBack)
        
        tableView.register(QuizTestTableViewCell.self, forCellReuseIdentifier: QuizTestTableViewCell.reuseID)
        tableView.layer.cornerRadius = 26
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 700
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            quizBack.topAnchor.constraint(equalTo: view.topAnchor),
            quizBack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizBack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizBack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension QuizTestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizTestTableViewCell.reuseID, for: indexPath) as? QuizTestTableViewCell else {
            fatalError("Could not cast to QuizTestTableViewCell")
        }
        cell.navigationController = self.navigationController
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

