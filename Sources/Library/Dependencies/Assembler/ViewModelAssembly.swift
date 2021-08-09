//
//  ViewModelAssembly.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import SwinjectAutoregistration
import Swinject

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewModelDefault.self) { resolver in
            HomeViewModelDefault(
                homeFetcher: resolver ~> (HomeFetcherDefault.self),
                factory: resolver ~> (HomeContentFactory.self),
                dataEngine: resolver ~> (CoreDataEngine.self)
            )
        }
    }
}
