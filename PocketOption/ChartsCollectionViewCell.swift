//
//  ChartsCollectionViewCell.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

class ChartsCollectionViewCell: UICollectionViewCell {
    
    let chartsImage = UIImageView()
    
    var levelButtonTappedHandler: (() -> Void)?
    static let reuseID = String(describing: ChartsCollectionViewCell.self)
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        chartsImage.image = UIImage(named: "cell1")
        chartsImage.layer.masksToBounds = true
        chartsImage.contentMode = .scaleAspectFit
        chartsImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chartsImage)
        
        NSLayoutConstraint.activate([
            chartsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            chartsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chartsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
