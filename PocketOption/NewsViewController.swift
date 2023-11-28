//
//  NewsViewController.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

enum NewsType {
    case breakNews
    case lastedNews
}

class NewsViewController: UIViewController {

    let sections: [NewsType] = [.breakNews, .lastedNews]
    let newsLogo = UIImageView()
    let breakingLab = UILabel()
    let latestLab = UILabel()
    var articles = [Article]()
    
    lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BreakCollectionViewCell.self, forCellWithReuseIdentifier: BreakCollectionViewCell.reuseID)
        collectionView.register(LatestCollectionViewCell.self, forCellWithReuseIdentifier: LatestCollectionViewCell.reuseID)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNews()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        
        newsLogo.image = UIImage(named: "news")
        newsLogo.layer.masksToBounds = true
        newsLogo.contentMode = .scaleAspectFit
        newsLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsLogo)
        
        breakingLab.text = "Breaking News"
        breakingLab.textAlignment = .left
        breakingLab.textColor = .white
        breakingLab.numberOfLines = 0
        breakingLab.font = UIFont(name: "NunitoSans-Bold", size: 20)
        breakingLab.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(breakingLab)
        
        latestLab.text = "Latest"
        latestLab.textAlignment = .left
        latestLab.textColor = .white
        latestLab.numberOfLines = 0
        latestLab.font = UIFont(name: "NunitoSans-Bold", size: 20)
        latestLab.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(latestLab)
        
        view.addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            newsLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            newsLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            breakingLab.topAnchor.constraint(equalTo: newsLogo.bottomAnchor, constant: 24),
            breakingLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            latestLab.topAnchor.constraint(equalTo: mainCollectionView.topAnchor, constant: 265),
            latestLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            mainCollectionView.topAnchor.constraint(equalTo: breakingLab.bottomAnchor, constant: -16),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func fetchNews() {
        NewsAPI().fetchArticles { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedArticles):
                    self?.articles = fetchedArticles
                    self?.mainCollectionView.reloadData()
                case .failure(let error):
                    // Handle the error (e.g., show an alert)
                    print(error.localizedDescription)
                }
            }
        }
    }

    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .breakNews
            switch section {
            case .breakNews:
                return self?.forYouSectionLayout()
            case .lastedNews:
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
                widthDimension: .absolute(200),
                heightDimension: .absolute(194)
            ),
            subitems: [item]
        )

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
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
                heightDimension: .absolute(84)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), // Группа также занимает всю доступную ширину
                heightDimension: .absolute(84)
            ),
            subitem: item,
            count: 1 // Только один элемент в группе
        )

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 37,
            leading: 16,
            bottom: 0,
            trailing: 16
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

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .breakNews:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BreakCollectionViewCell.reuseID,
                for: indexPath
            ) as? BreakCollectionViewCell else {
                fatalError("Could not cast to BreakCollectionViewCell")
            }

            if indexPath.row < articles.count {
                let article = articles[indexPath.row]
                cell.configure(with: article)
            }
            
            return cell
        case .lastedNews:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LatestCollectionViewCell.reuseID,
                for: indexPath
            ) as? LatestCollectionViewCell else {
                fatalError("Could not cast to LatestCollectionViewCell")
            }
            
            if indexPath.row < articles.count {
                let article = articles[indexPath.row]
                cell.configure(with: article)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .breakNews:
            return 2
        case .lastedNews:
            return articles.count
        }
    }
}

