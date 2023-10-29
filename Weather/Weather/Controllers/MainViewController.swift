//
//  MainViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 28/10/2023.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let sections = Sections()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.sections.sectionsList[sectionIndex]
            switch section {
            case .mainSection:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.6), height: .fractionalHeight(1), spacing: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.4), item: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .hourlySection:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.6), height: .fractionalHeight(1), spacing: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(70), height: .absolute(100), item: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .dailySection:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
                let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.4), item: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .detailSection:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
                let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.4), item: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                return section
            default:
                return nil
            }
        }
        
        
//        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
//        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.4), item: item, count: 1)
//        let section = NSCollectionLayoutSection(group: group)
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections.sectionsList[section] {
        case .mainSection:
            1
        case .hourlySection:
            24
        case .dailySection:
            3
        case .detailSection:
            6
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         switch sections.sectionsList[indexPath.section] {
         case .mainSection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainInfoCollectionViewCell", for: indexPath) as! MainInfoCollectionViewCell
             cell.setup()
             return cell
             
         case .hourlySection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyInfoCollectionViewCell", for: indexPath) as! HourlyInfoCollectionViewCell
             cell.setup()
             return cell
         case .dailySection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCollectionViewCell", for: indexPath) as! DailyCollectionViewCell
             cell.setup()
             return cell
         case .detailSection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCollectionViewCell", for: indexPath) as! DailyCollectionViewCell
             cell.setup()
             return cell
         }
         
     }
    
}
