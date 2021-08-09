//
//  UserViewModel.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Foundation
import RxSwift

struct UserViewModelInput {
    let loadUser: PublishSubject<Void>
}

struct UserViewModelOutput {
    let name: Observable<String>
    let photo: Observable<String>
    let bio: Observable<String>
    let numberOfPhotos: Observable<String>
    let numberOfCollections: Observable<String>
    let numberOfLikes: Observable<String>
    let location: Observable<String>
}


protocol UserViewModel {
    typealias Input = UserViewModelInput
    typealias Output = UserViewModelOutput
    
    var input: Input { get }
    var output: Output { get }
}


struct UserViewModelDefault: UserViewModel {
    
    var input: Input
    var output: Output
 
    private let userFetcher: UserFetcher
    var username: String
    
    init(userFetcher: UserFetcher, username: String) {
        self.userFetcher = userFetcher
        self.username = username
        
        let loadUser = PublishSubject<Void>()
        input = .init(loadUser: loadUser)
        
        let fetchResult = input.loadUser
            .flatMap { [userFetcher, username] _ in
                userFetcher.fetchUser(with: username)
            }
        
        let name = fetchResult.map { user in
            user.name ?? ""
        }
        
        let photo = fetchResult.map { user in
            user.profileImage?.medium ?? ""
        }
        
        let numberOfPhotos = fetchResult.map { user in
            user.totalPhotos ?? ""
        }
        
        
        output = .init(
            name: name,
            photo: photo
        )
    }
}
