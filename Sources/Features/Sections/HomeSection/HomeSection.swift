//
//  ImagesSection.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

final class HomeSection<CellViewModel: CollectionCellViewModel>: Section {
    typealias Cell = UICollectionViewCell & CellBindable
    
    var viewModel: HomeSectionViewModel<CellViewModel>
    private let cellConfigurator: ListCellConfigurator
   
    init(cellConfigurator: ListCellConfigurator, viewModel: HomeSectionViewModel<CellViewModel>) {
        self.viewModel = viewModel
        self.cellConfigurator = cellConfigurator
    }
    
    func numberOfItems() -> Int {
        viewModel.numberOfItems
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        cellConfigurator.layoutForItems()
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {        
        let cellViewModel = viewModel.viewModelForItem(at: indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellConfigurator.cellTypeForItem(with: cellViewModel).self), for: indexPath) as? Cell
            else { return UICollectionViewCell() }
        cell.bindViewModel(cellViewModel)
        return cell
    }
}
