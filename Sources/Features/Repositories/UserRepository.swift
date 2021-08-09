//
//  UserRepository.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/9/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserRepository {
    func fetchUser(with username: String) -> Observable<User>
}


final class UserRepositoryDefault: UserRepository {

    private let dataConvert: DataConvertService
    
    init(dataConvert: DataConvertService) {
        self.dataConvert = dataConvert
    }
    
    func fetchUser(with username: String) -> Observable<User> {
        Observable.create { [dataConvert] observer in
            let endpoint = APIEndpoints.getUser(with: username)
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
