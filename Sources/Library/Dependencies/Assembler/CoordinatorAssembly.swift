//
//  CoordinatorAssembly.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import SwinjectAutoregistration
import Swinject
import UIKit

final class CoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
            TabBarCoordinator.self,
            arguments: UINavigationController.self, Coordinator.self,
            initializer: TabBarCoordinator.init
        )
        
        container.autoregister(
            HomeCoordinator.self,
            arguments: UINavigationController.self, Coordinator.self,
            initializer: HomeCoordinator.init
        )
    }
}
