//
//  HomeFetcher.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol HomeFetcher {
    func fetch(with criteria: ImagesRequestDTO) -> Observable<[Image]>
    func fetchImage(with id: String) -> Observable<Image>
}

struct HomeFetcherDefault: HomeFetcher {
    
    let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func fetch(with criteria: ImagesRequestDTO) -> Observable<[Image]> {
        imageRepository.fetchImagesList(with: criteria)
    }
    
    func fetchImage(with id: String) -> Observable<Image> {
        imageRepository.fetchImage(with: id)
    }
}
