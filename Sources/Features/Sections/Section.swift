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
    case loading(viewModel: Any)
    case empty(viewModel: Any)
}

extension SectionType {
    var object: Any {
        switch self {
        case let .images(viewModel):
            return viewModel
        case let .loading(viewModel):
            return viewModel
        case let .empty(viewModel):
            return viewModel
        }
    }
}
