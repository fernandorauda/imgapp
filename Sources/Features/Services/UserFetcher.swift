//
//  UserFetcher.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/9/21.
//

import Foundation
import RxSwift

protocol UserFetcher {
    func fetchUser(with username: String) -> Observable<User>
}

struct UserFetcherDefault: UserFetcher {
    
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func fetchUser(with username: String) -> Observable<User> {
        userRepository.fetchUser(with: username)
    }
}
