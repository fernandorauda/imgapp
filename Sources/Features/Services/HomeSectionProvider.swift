//
//  HomeSectionProvider.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

protocol SectionControllerProvider {
    func sectionController(for section: SectionType) -> Section
}

final class HomeSectionControllerProvider: SectionControllerProvider {
    func sectionController(for section: SectionType) -> Section {
        switch section {
        case let .images(viewModel):
            guard let viewModel = viewModel as? HomeSectionViewModel<ImageCellViewModel> else { return NSObject() as! Section }
          
            return HomeSection<ImageCellViewModel>(
                cellConfigurator: ListCellConfigurator(cellClass: ImageCollectionViewCell.self, layout: homeSectionLayout()), viewModel: viewModel)
            
        case let .loading(viewModel):
            guard let viewModel = viewModel as? HomeSectionViewModel<LoadingCellViewModel> else { return NSObject() as! Section }
            
            return HomeSection<LoadingCellViewModel>(cellConfigurator: ListCellConfigurator(cellClass: LoadingCollectionViewCell.self, layout: loadingLayout()), viewModel: viewModel)
        }
    }
    
    func loadingLayout() -> NSCollectionLayoutSection {
        let loadItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let loadItem = NSCollectionLayoutItem(layoutSize: loadItemSize)
        
        
        let loadGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56))
        let loadGroup = NSCollectionLayoutGroup.horizontal(layoutSize: loadGroupSize, subitems: [loadItem])
        
        // Section
        let section = NSCollectionLayoutSection(group: loadGroup)
        
        return section
    }
    
    func homeSectionLayout() -> NSCollectionLayoutSection {
        let inset: CGFloat = 8
        
        // Image full width
        let fullItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let fullItem = NSCollectionLayoutItem(layoutSize: fullItemSize)
        fullItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Medium image
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Smaller image
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Smaller images group
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
        
        // Medium Image group
        let nestedLargeGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let nestedLargeGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedLargeGroupSize, subitems: [largeItem])
        
        // Medium and small image group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.75))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [nestedLargeGroup, nestedGroup])
        
        // Full width image and outerGroup group
        let finalOuterGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2))
        let finalOuterGroup = NSCollectionLayoutGroup.vertical(layoutSize: finalOuterGroupSize, subitems: [fullItem, outerGroup])
        
        // Section
        let section = NSCollectionLayoutSection(group: finalOuterGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        return section
    }
}
