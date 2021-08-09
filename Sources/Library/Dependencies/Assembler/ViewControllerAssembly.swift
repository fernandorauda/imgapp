//
//  ViewControllerAssembly.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import SwinjectAutoregistration
import Swinject

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {

        container.register(HomeViewController.self) { (resolver, delegate: HomeViewModelDelegate) in
            var viewModel = resolver.resolve(HomeViewModelDefault.self)
            viewModel?.delegate = delegate
            return HomeViewController(
                viewModel: viewModel!,
                sectionControllerProvider: resolver ~> (HomeSectionControllerProvider.self)
            )
        }
        
        container.register(LikesViewController.self) { resolver in
            LikesViewController(
                viewModel: resolver ~> (LikesViewModelDefault.self),
                sectionControllerProvider: resolver ~> (HomeSectionControllerProvider.self)
            )
        }
        
        container.register(UserViewController.self) { (resolver, username: String) in
            let viewModel = UserViewModelDefault(userFetcher: resolver ~> (UserFetcherDefault.self), username: username)
            return UserViewController(viewModel: viewModel)
        }
        
        container.autoregister(HomeSectionControllerProvider.self, initializer: HomeSectionControllerProvider.init)

    }
}
