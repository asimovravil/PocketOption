//
//  BreakCollectionViewCell.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit
import SDWebImage

class BreakCollectionViewCell: UICollectionViewCell {
    
    let newsCard = UIImageView()
    let newsLabel = UILabel()
    let dateLabel = UILabel()
    
    var levelButtonTappedHandler: (() -> Void)?
    static let reuseID = String(describing: BreakCollectionViewCell.self)
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newsCard.image = UIImage(named: "breakNewsImage")
        newsCard.layer.masksToBounds = true
        newsCard.layer.cornerRadius = 10
        newsCard.contentMode = .scaleAspectFill
        newsCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsCard)
        
        newsLabel.text = "US Factory Production Falls as Strikes Drive 10% Plunge in Autos"
        newsLabel.textAlignment = .left
        newsLabel.textColor = .white
        newsLabel.numberOfLines = 2
        newsLabel.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsLabel)
        
        dateLabel.text = "55 min ago"
        dateLabel.textAlignment = .left
        dateLabel.textColor = .white
        dateLabel.alpha = 0.50
        dateLabel.numberOfLines = 2
        dateLabel.font = UIFont(name: "NunitoSans-Regular", size: 12)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            newsCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsCard.heightAnchor.constraint(equalToConstant: 130),
            newsCard.widthAnchor.constraint(equalToConstant: 200),
            
            newsLabel.topAnchor.constraint(equalTo: newsCard.bottomAnchor, constant: 4),
            newsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: newsLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: newsBurger) {
        newsLabel.text = article.title
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            newsCard.sd_setImage(with: url, completed: nil)
        } else {
            newsCard.image = UIImage(named: "newest1")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy HH:mm"
        dateLabel.text = formatter.string(from: article.publishedAt)
    }
}
