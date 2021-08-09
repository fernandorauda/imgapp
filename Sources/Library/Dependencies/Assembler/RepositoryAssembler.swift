//
//  RepositoryAssembler.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import SwinjectAutoregistration
import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {

        container.register(ImagesRepositoryDefault.self) { resolver in
            ImagesRepositoryDefault(dataConvert: resolver ~> (DataConvertServiceDefault.self))
        }
        
        container.register(UserRepositoryDefault.self) { resolver in
            UserRepositoryDefault(dataConvert: resolver ~> (DataConvertServiceDefault.self))
        }

        container.autoregister(HomeContentFactory.self, initializer: HomeContentFactory.init)
    }
}
