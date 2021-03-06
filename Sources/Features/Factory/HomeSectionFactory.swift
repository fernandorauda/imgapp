//
//  SectionFactory.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Foundation

final class HomeContentFactory {
    func sections(images: [Image], isLoading: Bool, isEmpty: Bool = false) -> [SectionType] {
        var sections: [SectionType] = []
        if !images.isEmpty {
            sections.append(.images(viewModel: getImageListSection(images: images)))
        }
        
        if isLoading {
            sections.append(.loading(viewModel: HomeSectionViewModel(viewModels: [LoadingCellViewModel()]) ))
        }
        
        if isEmpty {
            sections.append(.empty(viewModel: HomeSectionViewModel(viewModels: [EmptyCellViewModel()]) ))
        }
        
        return sections
    }
    
    private func getImageListSection(images: [Image]) -> HomeSectionViewModel<ImageCellViewModel> {
        let cellViewModels = images.map { ImageCellViewModel(image: $0) }
        let imageList = HomeSectionViewModel<ImageCellViewModel>(viewModels: cellViewModels)
        return imageList
    }
}
