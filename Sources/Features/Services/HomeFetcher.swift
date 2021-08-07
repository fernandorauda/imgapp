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
    func fetch() -> Observable<[Image]?>
}

struct HomeFetcherDefault: HomeFetcher {
    
    let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func fetch() -> Observable<[Image]?> {
        imageRepository.fetchImagesList()
    }
}
