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

        container.register(HomeViewController.self) { resolver in
            HomeViewController(
                viewModel: resolver ~> (HomeViewModelDefault.self),
                sectionControllerProvider: resolver ~> (HomeSectionControllerProvider.self)
            )
        }
        
        container.register(LikesViewController.self) { resolver in
            LikesViewController(
                viewModel: resolver ~> (LikesViewModelDefault.self),
                sectionControllerProvider: resolver ~> (HomeSectionControllerProvider.self)
            )
        }
        
        container.autoregister(HomeSectionControllerProvider.self, initializer: HomeSectionControllerProvider.init)

    }
}
