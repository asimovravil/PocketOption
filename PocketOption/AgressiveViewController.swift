//
//  AgressiveViewController.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

class AgressiveViewController: UIViewController {

    let agressiveImage = UIImageView()
    let agressiveClose = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        agressiveImage.image = UIImage(named: "resultBack")
        agressiveImage.layer.masksToBounds = true
        agressiveImage.contentMode = .scaleAspectFit
        agressiveImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(agressiveImage)
        
        agressiveClose.setImage(UIImage(named: "close"), for: .normal)
        agressiveClose.addTarget(self, action: #selector(testStartClapped), for: .touchUpInside)
        agressiveClose.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(agressiveClose)
        
        NSLayoutConstraint.activate([
            agressiveImage.topAnchor.constraint(equalTo: view.topAnchor),
            agressiveImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            agressiveImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            agressiveImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            agressiveClose.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            agressiveClose.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func testStartClapped() {
        let controller = QuizTestViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
