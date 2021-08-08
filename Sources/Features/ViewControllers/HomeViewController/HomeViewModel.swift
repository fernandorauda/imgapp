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
    let restartPagination: PublishSubject<Void>
}

struct HomeViewModelOutput {
    let sections: Observable<[SectionType]>
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
    
    private let factory: HomeContentFactory
    private let homeFetcher: HomeFetcher
    
    init(homeFetcher: HomeFetcher, factory: HomeContentFactory) {
        self.homeFetcher = homeFetcher
        self.factory = factory
        
        let paginator = Paginator<Image> { page in
            let criteria = ImagesRequestDTO(page: page, perPage: 10)
            return homeFetcher.fetch(with: criteria)
        }
        
        input = .init(loadImages: paginator.onNext, restartPagination: paginator.onRestart)
        
        let loadingIndicator = paginator.onLoading.skip(while: { !$0 }).toVoid()
        
//        let restart = paginator.onRestart.do(onNext: { _ in
//            
//        }).toVoid()
        
        
        
        let sections = Observable.combineLatest(paginator.onUpdate, paginator.onRestart, loadingIndicator)
            .map { _ in
                factory.sections(images: paginator.models, isLoading: paginator.isLoading)
            }
        
        output = .init(sections: sections)
    }
    
}
