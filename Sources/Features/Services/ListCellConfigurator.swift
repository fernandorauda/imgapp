//
//  ListCellConfigurator.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

final class ListCellConfigurator {

    private let cellClass: AnyClass
    private let layout: NSCollectionLayoutSection

    init(cellClass: AnyClass, layout: NSCollectionLayoutSection) {
        self.cellClass = cellClass
        self.layout = layout
    }

    func cellTypeForItem(with viewModel: CollectionCellViewModel) -> AnyClass {
        cellClass
    }
    
    func layoutForItems() -> NSCollectionLayoutSection {
        layout
    }
    
}
