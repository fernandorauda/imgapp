//
//  Injector.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Swinject

enum Injector {
    static let current: Assembler = {
        let container = Container()
        let assembler = Assembler(
            [
                ViewModelAssembly(),
                ViewControllerAssembly(),
                FetcherAssembly(),
                RepositoryAssembly(),
                NetworkAssembly(),
                CoordinatorAssembly(),
                PersistencyAssembly()
            ],
            container: container
        )
        return assembler
    }()
}
