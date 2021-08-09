//
//  ViewModelAssembly.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import SwinjectAutoregistration
import Swinject
import UIKit

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewModelDefault.self) { resolver in
            var viewModel = HomeViewModelDefault(
                homeFetcher: resolver ~> (HomeFetcherDefault.self),
                factory: resolver ~> (HomeContentFactory.self),
                dataEngine: resolver ~> (CoreDataEngine.self)
            )
            viewModel.delegate = resolver.resolve(HomeCoordinatorDelegate.self)
            return viewModel
        }
        
        container.register(LikesViewModelDefault.self) { resolver in
            LikesViewModelDefault(
                factory: resolver ~> (HomeContentFactory.self),
                dataEngine: resolver ~> (CoreDataEngine.self)
            )
        }
        
        container.register(UserViewModelDefault.self) { resolver in
            UserViewModelDefault(
                userFetcher: resolver ~> (UserFetcherDefault.self),
                username: resolver ~> (String.self)
            )
        }
        
        container.register(ImageViewModelDefault.self) { resolver in
            ImageViewModelDefault(
                imageFetcher: resolver ~> (HomeFetcherDefault.self),
                id: resolver ~> (String.self)
            )
        }
    }
}
