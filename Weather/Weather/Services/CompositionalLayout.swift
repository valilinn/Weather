//
//  CompositionalLayout.swift
//  Weather
//
//  Created by Валентина Лінчук on 28/10/2023.
//

import UIKit

enum CompositionalGroupAlignment {
    case vertical
    case horizontal
}

struct CompositionalLayout {
    
    static func createItem(width: NSCollectionLayoutDimension,
                           height: NSCollectionLayoutDimension,
                           spacing: CGFloat
    ) -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height))
        //paddings between items
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return item
    }
    //the group with array of items
    static func createGroup(alignment: CompositionalGroupAlignment,
                            width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            items: [NSCollectionLayoutItem]
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: items)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: items)
        }
    }
    //the group with the same item
    static func createGroup(alignment: CompositionalGroupAlignment,
                            width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            item: NSCollectionLayoutItem,
                            count: Int
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitem: item, count: count)
//            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), repeatingSubitem: item, count: count)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitem: item, count: count)
//            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), repeatingSubitem: item, count: count)
        }
    }
}
