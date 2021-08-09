//
//  UserViewModel.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Foundation
import RxSwift
import RxCocoa

struct UserViewModelInput {
    let loadUser: PublishSubject<Void>
}

struct UserViewModelOutput {
    let isLoading: Observable<Bool>
    let name: Observable<String>
    let photo: Observable<String>
    let bio: Observable<String>
    let numberOfPhotos: Observable<String?>
    let numberOfCollections: Observable<String?>
    let numberOfLikes: Observable<String?>
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
        
        let isLoading = PublishRelay<Bool>()
        let loadUser = PublishSubject<Void>()
        input = .init(loadUser: loadUser)
        
        let fetchResult = input.loadUser
            .do(onNext: { _ in isLoading.accept(true) })
            .flatMap { [userFetcher, username] _ in
                userFetcher.fetchUser(with: username)
            }
        
        let name = fetchResult.map { user in
            user.name ?? ""
        }
        
        let photo = fetchResult.map { user in
            user.profileImage?.medium ?? ""
        }
        
        let bio = fetchResult.map { user in
            user.bio ?? ""
        }
        
        let numberOfPhotos = fetchResult.map { user in
            user.numberOfPhotos()
        }
        
        let numberOfCollections = fetchResult.map { user in
            user.numberOfCollections()
        }
        
        let numberOfLikes = fetchResult.map { user in
            user.numberOfLikes()
        }
        
        let location = fetchResult.map { user in
            user.location ?? ""
        }
        .do(onNext: { _ in isLoading.accept(false) })
        
        output = .init(
            isLoading: isLoading.asObservable(),
            name: name,
            photo: photo,
            bio: bio,
            numberOfPhotos: numberOfPhotos,
            numberOfCollections: numberOfCollections,
            numberOfLikes: numberOfLikes,
            location: location
        )
    }
}
