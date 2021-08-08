//
//  Section.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

protocol Section {
    func numberOfItems() -> Int
    //func layoutSection() -> UICollectionViewCompositionalLayout
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
    func layoutSection() -> UICollectionViewCompositionalLayout
}

final class ImagesSectionControllerProvider: SectionControllerProvider {
    func sectionController(for section: SectionType) -> Section {
        switch section {
        case let .images(viewModel):
            guard let viewModel = viewModel as? ImagesSectionViewModel<ImageCellViewModel> else { return NSObject() as! Section }
            return ImagesSection<ImageCellViewModel>(
                cellConfigurator: ListCellConfigurator(cellClass: ImageCollectionViewCell.self), viewModel: viewModel)
        }
    }
    
    func layoutSection() -> UICollectionViewCompositionalLayout {
        let inset: CGFloat = 8
        
        // Items
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Nested Group
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
        
        // Outer Group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
        
        let outerReverseGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [nestedGroup, nestedGroup, largeItem])
        
        let finalOuterGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [outerGroup, outerReverseGroup])
        
        // Section
        let section = NSCollectionLayoutSection(group: outerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Supplementary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(0))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return UICollectionViewCompositionalLayout(section: section)
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
    
    private func getImageListSection(images: [Image]) -> ImagesSectionViewModel<ImageCellViewModel> {
        let cellViewModels = images.map { _ in ImageCellViewModel() }
        let imageList = ImagesSectionViewModel(viewModels: cellViewModels)
        return imageList
    }
}
