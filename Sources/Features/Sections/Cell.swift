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

    init(cellClass: AnyClass) {
        self.cellClass = cellClass
    }

    func cellTypeForItem(with viewModel: CollectionCellViewModel) -> AnyClass {
        cellClass
    }
}
