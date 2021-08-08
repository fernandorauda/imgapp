//
//  ImageRepository.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ImageRepository {
    func fetchImagesList(with criteria: ImagesRequestDTO) -> Observable<[Image]>
}


final class ImagesRepositoryDefault: ImageRepository {

    private let dataConvert: DataConvertService
    
    init(dataConvert: DataConvertService) {
        self.dataConvert = dataConvert
    }
    
    func fetchImagesList(with criteria: ImagesRequestDTO) -> Observable<[Image]> {
        Observable.create { [dataConvert] observer in
            let endpoint = APIEndpoints.getImages(with: criteria)
            dataConvert.request(with: endpoint) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
