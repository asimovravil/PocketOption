//
//  ResultViewController.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var progressLabel = UILabel()
    let processing = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        
        setupCircularProgressView()
        setupProgressLabel()
        
        processing.text = "Processing..."
        processing.textAlignment = .center
        processing.textColor = .white
        processing.numberOfLines = 0
        processing.font = UIFont(name: "NunitoSans-Bold", size: 24)
        processing.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(processing)
        
        NSLayoutConstraint.activate([
            processing.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 100),
            processing.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func setupProgressLabel() {
        progressLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        progressLabel.center = view.center
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont(name: "NunitoSans-Bold", size: 36)
        progressLabel.textColor = .white
        progressLabel.text = "0%"
        view.addSubview(progressLabel)
    }
    
    func setupCircularProgressView() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // Setup trackLayer (Circular Path)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        // Setup shapeLayer (Progress Line)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        // Start the progress animation
        startProgressAnimation()
    }
}

extension ResultViewController {
    func startProgressAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2 // Adjust duration as needed
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        shapeLayer.add(animation, forKey: "progressAnim")

        let displayLink = CADisplayLink(target: self, selector: #selector(updateProgressLabel))
        displayLink.add(to: .current, forMode: .default)
    }

    @objc func updateProgressLabel() {
        let progress = shapeLayer.presentation()?.strokeEnd ?? 0
        progressLabel.text = "\(Int(progress * 100))%"
    }
}


extension ResultViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            navigateToFAQViewController()
        }
    }
    
    func navigateToFAQViewController() {
        let controller = TestViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

