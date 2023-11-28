//
//  NewsPageTableViewCell.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit
import SDWebImage

final class NewsPageTableViewCell: UITableViewCell {

    static let reuseID = String(describing: NewsPageTableViewCell.self)
    var nextNewsButtonTappedHandler: (() -> Void)?
    
    let newsImageCell = UIImageView()
    let newsCard = UIView()
    let newsDateCell = UILabel()
    let newsLabelCell = UILabel()
    let newsSubLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        newsImageCell.image = UIImage(named: "newsImageCell")
        newsImageCell.layer.masksToBounds = true
        newsImageCell.contentMode = .scaleAspectFill
        newsImageCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsImageCell)
        
        newsCard.layer.cornerRadius = 30
        newsCard.backgroundColor = Burger.newsBack.uiColor
        newsCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsCard)
        
        newsDateCell.text = "3 hours ago"
        newsDateCell.textAlignment = .left
        newsDateCell.textColor = .white
        newsDateCell.alpha = 0.50
        newsDateCell.numberOfLines = 0
        newsDateCell.font = UIFont(name: "NunitoSans-Regular", size: 12)
        newsDateCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsDateCell)
        
        newsLabelCell.text = "Gold Price Forecast: XAU/USD rises as weak US data fueled dovish bets on the Fed"
        newsLabelCell.textAlignment = .left
        newsLabelCell.textColor = .white
        newsLabelCell.numberOfLines = 0
        newsLabelCell.font = UIFont(name: "NunitoSans-Bold", size: 32)
        newsLabelCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsLabelCell)
        
        newsSubLabel.text = "Gold Price Forecast: XAU/USD rises as weak US data fueled dovish bets on the Fed"
        newsSubLabel.textAlignment = .left
        newsSubLabel.textColor = .white
        newsSubLabel.numberOfLines = 0
        newsSubLabel.font = UIFont(name: "NunitoSans-Regular", size: 16)
        newsSubLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsSubLabel)
        
        NSLayoutConstraint.activate([
            newsImageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -150),
            newsImageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageCell.heightAnchor.constraint(equalToConstant: 303),
            
            newsCard.topAnchor.constraint(equalTo: newsImageCell.bottomAnchor, constant: -30),
            newsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            newsDateCell.topAnchor.constraint(equalTo: newsCard.topAnchor, constant: 24),
            newsDateCell.leadingAnchor.constraint(equalTo: newsCard.leadingAnchor, constant: 24),
            
            newsLabelCell.topAnchor.constraint(equalTo: newsDateCell.bottomAnchor, constant: 8),
            newsLabelCell.leadingAnchor.constraint(equalTo: newsCard.leadingAnchor, constant: 24),
            newsLabelCell.trailingAnchor.constraint(equalTo: newsCard.trailingAnchor, constant: -24),
            
            newsSubLabel.topAnchor.constraint(equalTo: newsLabelCell.bottomAnchor, constant: 24),
            newsSubLabel.leadingAnchor.constraint(equalTo: newsCard.leadingAnchor, constant: 24),
            newsSubLabel.trailingAnchor.constraint(equalTo: newsCard.trailingAnchor, constant: -24),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    func configure(with article: Article) {
        newsLabelCell.text = article.title
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            newsImageCell.sd_setImage(with: url, completed: nil)
        } else {
            newsImageCell.image = UIImage(named: "breakNewsImage")
        }

        newsSubLabel.text = article.description
    }
}
