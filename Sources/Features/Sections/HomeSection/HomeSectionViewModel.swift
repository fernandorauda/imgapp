//
//  HomeSectionViewModel.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Foundation


struct HomeSectionViewModel<CellViewModel: CollectionCellViewModel>: SectionViewModel {
    
    let viewModels: [CellViewModel]
    
    init(viewModels: [CellViewModel]) {
        self.viewModels = viewModels
    }
    
    var numberOfItems: Int {
        viewModels.count
    }
    
    func viewModelForItem(at index: Int) -> CollectionCellViewModel {
        viewModels[index]
    }
}
