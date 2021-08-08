//
//  Cell.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

protocol CellBindable {
    func bindViewModel(_ viewModel: Any)
}

protocol CollectionCellViewModel {}


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
