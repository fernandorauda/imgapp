//
//  FetcherAssembly.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import SwinjectAutoregistration
import Swinject

final class FetcherAssembly: Assembly {
    func assemble(container: Container) {

        container.register(HomeFetcherDefault.self) { resolver in
            HomeFetcherDefault(imageRepository: resolver ~> (ImagesRepositoryDefault.self))
        }
        
        container.register(UserFetcherDefault.self) { resolver in
            UserFetcherDefault(userRepository: resolver ~> (UserRepositoryDefault.self))
        }

    }
}
