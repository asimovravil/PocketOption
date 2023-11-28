//
//  ChartsViewController.swift
//  PocketOption
//
//  Created by Ravil on 28.11.2023.
//

import UIKit

enum SectionType {
    case main
}

class ChartsViewController: UIViewController {

    let sections: [SectionType] = [.main]
    let chartsLogo = UIImageView()
    let categoryImage = UIImageView()
    
    // MARK: - UI
    
    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChartsCollectionViewCell.self, forCellWithReuseIdentifier: ChartsCollectionViewCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: CGFloat(0x1D) / 255.0, green: CGFloat(0x1F) / 255.0, blue: CGFloat(0x2F) / 255.0, alpha: 1.0)
        
        chartsLogo.image = UIImage(named: "charts")
        chartsLogo.layer.masksToBounds = true
        chartsLogo.contentMode = .scaleAspectFit
        chartsLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartsLogo)

        categoryImage.image = UIImage(named: "category")
        categoryImage.layer.masksToBounds = true
        categoryImage.contentMode = .scaleAspectFit
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryImage)
        view.addSubview(mainCollectionView)
        NSLayoutConstraint.activate([
            chartsLogo.bottomAnchor.constraint(equalTo: categoryImage.topAnchor, constant: -24),
            chartsLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            categoryImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 204),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .main
            switch section {
            case .main:
                return self?.mainSectionLayout()
            }
        }
    }
        
    func mainSectionLayout() -> NSCollectionLayoutSection {
        let itemSection = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(202)
            )
        )
        let groupSizeSection = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(180)
        )
        let groupSection = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSizeSection,
            subitems: [itemSection, itemSection]
        )
        let section = NSCollectionLayoutSection(group: groupSection)
        section.interGroupSpacing = 40
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
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

extension ChartsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ChartsCollectionViewCell.reuseID,
                for: indexPath
            ) as? ChartsCollectionViewCell else {
                fatalError("Could not cast to ChartsCollectionViewCell")
            }
            
            switch indexPath.row {
            case 0:
                cell.chartsImage.image = UIImage(named: "cell1")
            case 1:
                cell.chartsImage.image = UIImage(named: "cell2")
            case 2:
                cell.chartsImage.image = UIImage(named: "cell3")
            case 3:
                cell.chartsImage.image = UIImage(named: "cell4")
            case 4:
                cell.chartsImage.image = UIImage(named: "cell5")
            case 5:
                cell.chartsImage.image = UIImage(named: "cell6")
            default:
                cell.chartsImage.image = UIImage(named: "cell1")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .main:
            return 6
        }
    }
}
