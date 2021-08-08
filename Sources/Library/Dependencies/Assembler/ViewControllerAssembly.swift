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
            HomeViewController(viewModel: resolver ~> (HomeViewModelDefault.self), sectionControllerProvider: resolver ~> (ImagesSectionControllerProvider.self))
        }
        
        container.autoregister(ImagesSectionControllerProvider.self, initializer: ImagesSectionControllerProvider.init)

    }
}
