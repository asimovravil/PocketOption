//
//  LatestCollectionViewCell.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit
import SDWebImage

class LatestCollectionViewCell: UICollectionViewCell {
    
    let latestCard = UIImageView()
    let latestLabel = UILabel()
    let latestDate = UILabel()
    
    var levelButtonTappedHandler: (() -> Void)?
    static let reuseID = String(describing: LatestCollectionViewCell.self)
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        latestCard.image = UIImage(named: "latestNewsImage")
        latestCard.layer.masksToBounds = true
        latestCard.layer.cornerRadius = 10
        latestCard.contentMode = .scaleAspectFill
        latestCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(latestCard)
        
        latestLabel.text = "Gold Price Forecast: XAU/USD rises as weak US data fueled dovish bets on the Fed"
        latestLabel.textAlignment = .left
        latestLabel.textColor = .white
        latestLabel.numberOfLines = 2
        latestLabel.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        latestLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(latestLabel)
        
        latestDate.text = "3 hours ago"
        latestDate.textAlignment = .left
        latestDate.textColor = .white
        latestDate.alpha = 0.50
        latestDate.numberOfLines = 2
        latestDate.font = UIFont(name: "NunitoSans-Regular", size: 12)
        latestDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(latestDate)
        
        NSLayoutConstraint.activate([
            latestCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            latestCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            latestCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            latestCard.heightAnchor.constraint(equalToConstant: 84),
            latestCard.widthAnchor.constraint(equalToConstant: 84),
            
            latestLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            latestLabel.leadingAnchor.constraint(equalTo: latestCard.trailingAnchor, constant: 8),
            latestLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            latestDate.topAnchor.constraint(equalTo: latestLabel.bottomAnchor, constant: 4),
            latestDate.leadingAnchor.constraint(equalTo: latestCard.trailingAnchor, constant: 8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: Article) {
        latestLabel.text = article.title
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            latestCard.sd_setImage(with: url, completed: nil)
        } else {
            latestCard.image = UIImage(named: "newest1")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy HH:mm"
        latestDate.text = formatter.string(from: article.publishedAt)
    }
}
