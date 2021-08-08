//
//  HomeViewModel.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation
import RxSwift

struct HomeViewModelInput {
    let loadImages: PublishSubject<Void>
}

struct HomeViewModelOutput {
    let images: Observable<[SectionType]>
}

protocol HomeViewModel {
    typealias Input = HomeViewModelInput
    typealias Output = HomeViewModelOutput
    
    var input: Input { get }
    var output: Output { get }
}

struct HomeViewModelDefault: HomeViewModel {
    
    let input: Input
    let output: Output
    
    let factory = HomeContentFactory()
    
    private let homeFetcher: HomeFetcher
    
    init(homeFetcher: HomeFetcher) {
        self.homeFetcher = homeFetcher
        
        let loadImages = PublishSubject<Void>()
        input = .init(loadImages: loadImages)
        
        let imagesResult = input.loadImages
            .flatMapLatest { [homeFetcher, factory] _ -> Observable<[SectionType]> in
                homeFetcher.fetch().map { images -> [SectionType] in
                    factory.sections(images: images ?? [])
                }
            }
        
        output = .init(images: imagesResult)
    }
    
}
