//
//  TestViewController.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import UIKit

class TestViewController: UIViewController {

    let testTitle = UILabel()
    let testSubTitle = UILabel()
    let testImage = UIImageView()
    let testStart = UIButton()
    let testSkip = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        
        testTitle.text = "Test"
        testTitle.textAlignment = .center
        testTitle.textColor = .blue
        testTitle.numberOfLines = 0
        testTitle.font = UIFont(name: "NunitoSans-Regular", size: 16)
        testTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testTitle)
        
        testSubTitle.text = "WHAT TYPE OF INVESTOR ARE YOU?"
        testSubTitle.textAlignment = .center
        testSubTitle.textColor = .white
        testSubTitle.numberOfLines = 0
        testSubTitle.font = UIFont(name: "NunitoSans-ExtraBold", size: 32)
        testSubTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testSubTitle)
        
        testImage.image = UIImage(named: "testImage")
        testImage.layer.masksToBounds = true
        testImage.contentMode = .scaleAspectFit
        testImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testImage)
        
        testStart.setImage(UIImage(named: "herewego"), for: .normal)
        testStart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testStart)
        
        testSkip.setTitle("Skip for now", for: .normal)
        testSkip.titleLabel?.textColor = .white
        testSkip.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        testSkip.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testSkip)
        
        NSLayoutConstraint.activate([
            testTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            testTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            testTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            testSubTitle.topAnchor.constraint(equalTo: testTitle.bottomAnchor, constant: 25),
            testSubTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            testSubTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            testImage.topAnchor.constraint(equalTo: testSubTitle.bottomAnchor),
            testImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            testStart.bottomAnchor.constraint(equalTo: testSkip.topAnchor, constant: -8),
            testStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            testSkip.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            testSkip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
