//
//  ImageViewModel.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/9/21.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

struct ImageViewModelInput {
    let loadImage: PublishSubject<Void>
}

struct ImageViewModelOutput {
    let isLoading: Observable<Bool>
    let userName: Observable<String>
    let desc: Observable<String>
    let userPhoto: Observable<String>
    let mainPhoto: Observable<String>
    let date: Observable<String>
}


protocol ImageViewModel {
    typealias Input = ImageViewModelInput
    typealias Output = ImageViewModelOutput
    
    var input: Input { get }
    var output: Output { get }
}


struct ImageViewModelDefault: ImageViewModel {
    
    var input: Input
    var output: Output
 
    private let imageFetcher: HomeFetcher
    private var id: String
    
    init(imageFetcher: HomeFetcher, id: String) {
        self.imageFetcher = imageFetcher
        self.id = id
        
        let isLoading = PublishRelay<Bool>()
        let loadImage = PublishSubject<Void>()
        
        input = .init(loadImage: loadImage)
        
        let fetchResult = input.loadImage
            .do(onNext: { _ in isLoading.accept(true) })
            .flatMap { [imageFetcher, id] _ in
                imageFetcher.fetchImage(with: id)
            }
        
        let name = fetchResult.map { image in
            image.user?.name ?? ""
        }
        
        let desc = fetchResult.map { image in
            image.desc ?? ""
        }
        
        let userPhoto = fetchResult.map { image in
            image.user?.profileImage?.medium ?? ""
        }
        
        let date = fetchResult.map { image in
            DateFormatterDefault(date: image.createdAt ?? "").convertToFriendly()
        }.do(onNext: { _ in isLoading.accept(false) })
        
        let mainPhoto = fetchResult.map { image in
            image.urls?.full ?? ""
        }
        
        output = .init(
            isLoading: isLoading.asObservable(),
            userName: name,
            desc: desc,
            userPhoto: userPhoto,
            mainPhoto: mainPhoto,
            date: date
        )
    }
}
