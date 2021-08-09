//
//  LikesViewModel.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Foundation
import RxSwift

struct LikesViewModelInput {
    let loadImages: PublishSubject<Void>
    let sendFavorite: PublishSubject<Image>
}

struct LikesViewModelOutput {
    let sections: Observable<[SectionType]>
    let favorite: Observable<Void>
}

protocol LikesViewModel {
    typealias Input = LikesViewModelInput
    typealias Output = LikesViewModelOutput
    
    var input: Input { get }
    var output: Output { get }
}

struct LikesViewModelDefault: LikesViewModel {
    let input: Input
    let output: Output
    
    private let factory: HomeContentFactory
    private let dataEngine: DataEngine
    
    init(factory: HomeContentFactory, dataEngine: DataEngine) {
        self.factory = factory
        self.dataEngine = dataEngine
        
        let loadImages = PublishSubject<Void>()
        let sendFavorite = PublishSubject<Image>()
        input = Input(loadImages: loadImages, sendFavorite: sendFavorite)
        
        let sections = input.loadImages
            .flatMapLatest { [dataEngine, factory] _ -> Observable<[SectionType]> in
                dataEngine.getItems().map { items -> [SectionType] in
                    factory.sections(images: items ?? [], isLoading: false, isEmpty: items?.isEmpty ?? false)
                }
            }
        
        let sendFavResult = input.sendFavorite
            .map { item in
                dataEngine.save(item: item)
            }
        
        output = .init(sections: sections, favorite: sendFavResult)
    }
}
