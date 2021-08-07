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
    let images: Observable<[Image]?>
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
    
    private let homeFetcher: HomeFetcher
    
    init(homeFetcher: HomeFetcher) {
        self.homeFetcher = homeFetcher
        
        let loadImages = PublishSubject<Void>()
        input = .init(loadImages: loadImages)
        
        let imagesResult = input.loadImages
            .flatMapLatest { [homeFetcher] _ -> Observable<[Image]?> in
                homeFetcher.fetch()
            }
        
        output = .init(images: imagesResult)
    }
    
}
