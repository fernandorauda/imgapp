//
//  Section.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

protocol Section {
    func numberOfItems() -> Int
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

protocol SectionViewModel {
    associatedtype CellViewModel
    var viewModels: [CellViewModel] { get }
}

enum SectionType {
    case images(viewModel: Any)
}

extension SectionType {
    var object: Any {
        switch self {
        case let .images(viewModel):
            return viewModel
        }
    }
}

protocol SectionControllerProvider {
    func sectionController(for section: SectionType) -> Section
}

final class ImagesSectionControllerProvider: SectionControllerProvider {
    func sectionController(for section: SectionType) -> Section {
        switch section {
        case let .images(viewModel):
            guard let viewModel = viewModel as? HomeSectionViewModel<ImageCellViewModel> else { return NSObject() as! Section }
            return HomeSection<ImageCellViewModel>(
                cellConfigurator: ListCellConfigurator(cellClass: ImageCollectionViewCell.self, layout: homeSectionLayout()), viewModel: viewModel)
        }
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


final class HomeContentFactory {
    func sections(images: [Image]) -> [SectionType] {
        var sections: [SectionType] = []
        if !images.isEmpty {
            sections.append(.images(viewModel: getImageListSection(images: images)))
        }
        return sections
    }
    
    private func getImageListSection(images: [Image]) -> HomeSectionViewModel<ImageCellViewModel> {
        let cellViewModels = images.map { ImageCellViewModel(image: $0) }
        let imageList = HomeSectionViewModel<ImageCellViewModel>(viewModels: cellViewModels)
        return imageList
    }
}
