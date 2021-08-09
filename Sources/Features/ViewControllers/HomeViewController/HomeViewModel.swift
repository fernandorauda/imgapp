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
    let sendFavorite: PublishSubject<Image>
}

struct HomeViewModelOutput {
    let sections: Observable<[SectionType]>
    let favorite: Observable<Void>
}

protocol HomeViewModel {
    typealias Input = HomeViewModelInput
    typealias Output = HomeViewModelOutput
    
    var input: Input { get }
    var output: Output { get }
    
    func navigateToUser(username: String)
    func navigateToImage(id: String)
}

struct HomeViewModelDefault: HomeViewModel {
    
    let input: Input
    let output: Output
    
    weak var delegate: HomeCoordinatorDelegate?
    
    private let factory: HomeContentFactory
    private let homeFetcher: HomeFetcher
    private let dataEngine: DataEngine
    
    init(homeFetcher: HomeFetcher, factory: HomeContentFactory, dataEngine: DataEngine) {
        self.homeFetcher = homeFetcher
        self.factory = factory
        self.dataEngine = dataEngine
        
        let paginator = Paginator<Image> { page in
            let criteria = ImagesRequestDTO(page: page, perPage: 10)
            return homeFetcher.fetch(with: criteria)
        }
        
        let sendFavorite = PublishSubject<Image>()
        input = .init(loadImages: paginator.onNext, restartPagination: paginator.onRestart, sendFavorite: sendFavorite)
        
        let loadingIndicator = paginator.onLoading.skip(while: { !$0 }).toVoid()

        let sendFavResult = input.sendFavorite
            .map { item in
                dataEngine.save(item: item)
            }
        
        let sections = Observable.combineLatest(paginator.onUpdate, paginator.onRestart, loadingIndicator)
            .map { _ in
                factory.sections(images: paginator.models, isLoading: paginator.isLoading)
            }
        
        output = .init(sections: sections, favorite: sendFavResult)
    }
    
    // MARK: - Navigation

    func navigateToUser(username: String) {
        delegate?.homeCoordinatorDidNavigateToUser(username)
    }
    
    func navigateToImage(id: String) {
        delegate?.homeCoordinatorDidNavigateToImage(id)
    }
    
}
