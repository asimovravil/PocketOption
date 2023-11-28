//
//  FAQViewController.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import UIKit

class FAQViewController: UIViewController {
    
    var sectionPageList = 0
    
    let sectionImage = UIImageView()
    let sectionTitle = UILabel()
    let sectionSubTitle = UILabel()
    let sectionPage = UIPageControl()
    let sectionNext = UIButton()
    let sectionSkip = UIButton()
    
    func updateContentForPage(_ page: Int) {
        let sectionData = sectionFAQ[page]
        sectionTitle.text = sectionData.sectionTitle
        sectionSubTitle.text = sectionData.sectionSubTitle
        sectionImage.image = UIImage(named: sectionData.sectionImage)
    }
    
    @objc func sectionNextClapped() {
        if sectionPageList < sectionFAQ.count - 1 {
            sectionPageList += 1
        } else {
            let controller = TestViewController()
            controller.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        updateContentForPage(sectionPageList)
        sectionPage.currentPage = sectionPageList
    }
    
    private func setupNavigationBar() {
        let sectionSkipBarButton = UIBarButtonItem(customView: sectionSkip)
        navigationItem.rightBarButtonItem = sectionSkipBarButton
        sectionSkip.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    @objc private func skipButtonTapped() {
        let controller = TestViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        updateContentForPage(sectionPageList)
        setupNavigationBar()
        
        sectionSkip.setTitle("Skip", for: .normal)
        sectionSkip.setTitleColor(.white, for: .normal)
        sectionSkip.titleLabel?.alpha = 0.40
        sectionSkip.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 14)
        view.addSubview(sectionSkip)
        
        sectionImage.layer.masksToBounds = true
        sectionImage.contentMode = .scaleAspectFit
        sectionImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionImage)
        
        sectionTitle.textAlignment = .left
        sectionTitle.textColor = .white
        sectionTitle.numberOfLines = 0
        sectionTitle.font = UIFont(name: "NunitoSans-ExtraBold", size: 32)
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionTitle)
        
        sectionSubTitle.textAlignment = .left
        sectionSubTitle.textColor = .white
        sectionSubTitle.numberOfLines = 0
        sectionSubTitle.alpha = 0.40
        sectionSubTitle.font = UIFont(name: "NunitoSans-Regular", size: 14)
        sectionSubTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionSubTitle)
        
        sectionPage.numberOfPages = sectionFAQ.count
        sectionPage.currentPage = sectionPageList
        sectionPage.currentPageIndicatorTintColor = .blue
        sectionPage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionPage)
        
        sectionNext.setImage(UIImage(named: "sectionNext"), for: .normal)
        sectionNext.addTarget(self, action: #selector(sectionNextClapped), for: .touchUpInside)
        sectionNext.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionNext)
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                sectionImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            ])
        } else {
            NSLayoutConstraint.activate([
                sectionImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                sectionImage.heightAnchor.constraint(equalToConstant: 280),
            ])
        }
        
        NSLayoutConstraint.activate([
            sectionImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sectionImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            sectionTitle.bottomAnchor.constraint(equalTo: sectionSubTitle.topAnchor, constant: -8),
            sectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sectionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sectionSubTitle.bottomAnchor.constraint(equalTo: sectionNext.topAnchor, constant: -24),
            sectionSubTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sectionSubTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sectionPage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            sectionPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            sectionNext.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            sectionNext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
            ])
        } else {
            NSLayoutConstraint.activate([
            ])
        }
    }
}

