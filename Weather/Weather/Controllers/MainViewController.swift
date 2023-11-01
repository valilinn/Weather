//
//  MainViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 28/10/2023.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let sections = Sections()
    private let settings = Settings()
    var viewModel = WeatherViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = UIColor.clear
        
        viewModel.completionHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        updateValues()
        refresh()
    }
    
    func refresh() {
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc
    func refreshData(_ sender: UIRefreshControl) {
        
        viewModel.updateWeatherValues() // или любой другой метод, обновляющий данные
        
        sender.endRefreshing()
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
                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.7), height: .fractionalHeight(1), spacing: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(70), height: .absolute(100), item: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                return section
            case .dailySection:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.3), spacing: 0)
                let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .absolute(240), item: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                return section
            case .detailSection:
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(200), item: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                return section
            }
        }
    }
    
    //size of headers
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    func updateValues() {
        viewModel.updateWeatherValues()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SettingsViewController {
            destinationVC.settings = settings
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections.sectionsList[section] {
        case .mainSection:
            return 1
        case .hourlySection:
            collectionView.reloadData()
            if viewModel.hours.count == 1 {
                return viewModel.hours.count
            } else {
                return 24
            }
        case .dailySection:
            return 3
        case .detailSection:
            return 6
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         switch sections.sectionsList[indexPath.section] {
         case .mainSection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainInfoCollectionViewCell", for: indexPath) as! MainInfoCollectionViewCell
             cell.viewModel = viewModel
             cell.setupBinders()
             return cell
             
         case .hourlySection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyInfoCollectionViewCell", for: indexPath) as! HourlyInfoCollectionViewCell
             cell.viewModel = viewModel
             DispatchQueue.main.async {
                 cell.setupBinders(indexPath.row)
                 cell.setup()
             }
             return cell
             
         case .dailySection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCollectionViewCell", for: indexPath) as! DailyCollectionViewCell
             cell.viewModel = viewModel
             DispatchQueue.main.async {
                 cell.setupBinders(indexPath.row)
                 cell.setup()
             }
             return cell
         case .detailSection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
             cell.setup()
             return cell
         }
         
     }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeaderReusableView", for: indexPath) as! CollectionViewHeaderReusableView
            header.setup(sections.sectionsList[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}
