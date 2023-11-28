//
//  ForYouTodayCollectionViewCell.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

class ForYouTodayCollectionViewCell: UICollectionViewCell {
    
    let cardForYouImage = UIImageView()
    
    var levelButtonTappedHandler: (() -> Void)?
    static let reuseID = String(describing: ChartsCollectionViewCell.self)
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cardForYouImage.image = UIImage(named: "cell1")
        cardForYouImage.layer.masksToBounds = true
        cardForYouImage.contentMode = .scaleAspectFill
        cardForYouImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardForYouImage)
        
        NSLayoutConstraint.activate([
            cardForYouImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardForYouImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardForYouImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardForYouImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
