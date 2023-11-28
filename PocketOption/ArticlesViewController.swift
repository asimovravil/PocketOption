//
//  ArticlesViewController.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

enum ArticlesType {
    case cardForYou
    case cardNewest
}

class ArticlesViewController: UIViewController {

    let sections: [ArticlesType] = [.cardForYou, .cardNewest]
    let articlesLogo = UIImageView()
    let forYouToday = UILabel()
    let newestLab = UILabel()
    
    lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ForYouTodayCollectionViewCell.self, forCellWithReuseIdentifier: ForYouTodayCollectionViewCell.reuseID)
        collectionView.register(NewestCollectionViewCell.self, forCellWithReuseIdentifier: NewestCollectionViewCell.reuseID)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        
        articlesLogo.image = UIImage(named: "articles")
        articlesLogo.layer.masksToBounds = true
        articlesLogo.contentMode = .scaleAspectFit
        articlesLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articlesLogo)
        
        forYouToday.text = "For You Today"
        forYouToday.textAlignment = .left
        forYouToday.textColor = .white
        forYouToday.numberOfLines = 0
        forYouToday.font = UIFont(name: "NunitoSans-Bold", size: 20)
        forYouToday.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forYouToday)
        
        newestLab.text = "Newest"
        newestLab.textAlignment = .left
        newestLab.textColor = .white
        newestLab.numberOfLines = 0
        newestLab.font = UIFont(name: "NunitoSans-Bold", size: 20)
        newestLab.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newestLab)
        
        view.addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            articlesLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            articlesLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            forYouToday.topAnchor.constraint(equalTo: articlesLogo.bottomAnchor, constant: 24),
            forYouToday.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            newestLab.topAnchor.constraint(equalTo: mainCollectionView.topAnchor, constant: 235),
            newestLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            mainCollectionView.topAnchor.constraint(equalTo: forYouToday.bottomAnchor, constant: -16),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .cardForYou
            switch section {
            case .cardForYou:
                return self?.forYouSectionLayout()
            case .cardNewest:
                return self?.newestSectionLayout()
            }
        }
    }
    
    private func forYouSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(330),
                heightDimension: .absolute(190)
            ),
            subitems: [item]
        )

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func newestSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), // Занимает всю доступную ширину
                heightDimension: .absolute(320)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), // Группа также занимает всю доступную ширину
                heightDimension: .absolute(320)
            ),
            subitem: item,
            count: 1 // Только один элемент в группе
        )

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(43)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

extension ArticlesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .cardForYou:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ForYouTodayCollectionViewCell.reuseID,
                for: indexPath
            ) as? ForYouTodayCollectionViewCell else {
                fatalError("Could not cast to ForYouTodayCollectionViewCell")
            }
            switch indexPath.row {
            case 0:
                cell.cardForYouImage.image = UIImage(named: "card1")
            case 1:
                cell.cardForYouImage.image = UIImage(named: "card2")
            default:
                cell.cardForYouImage.image = UIImage(named: "card1")
            }
            return cell
        case .cardNewest:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewestCollectionViewCell.reuseID,
                for: indexPath
            ) as? NewestCollectionViewCell else {
                fatalError("Could not cast to NewestCollectionViewCell")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .cardForYou:
            return 2
        case .cardNewest:
            return 2
        }
    }
}
