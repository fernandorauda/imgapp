//
//  PersistencyAssembly.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import SwinjectAutoregistration
import Swinject

final class PersistencyAssembly: Assembly {
    func assemble(container: Container) {

        container.register(DataManager.self) { resolver in
            DataManager(engine: resolver ~> (CoreDataEngine.self))
        }

        container.autoregister(CoreDataEngine.self, initializer: CoreDataEngine.init)
    }
}
