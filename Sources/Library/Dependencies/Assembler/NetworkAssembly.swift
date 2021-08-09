//
//  NetworkAssembly.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import SwinjectAutoregistration
import Foundation
import Swinject

final class NetworkAssembly: Assembly {
    
    lazy var urlConfiguration = UrlConfiguration()
    
    func assemble(container: Container) {

        container.register(DataConvertServiceDefault.self) { resolver in
            DataConvertServiceDefault(with: resolver ~> (NetworkServiceDefault.self))
        }
        
        container.register(NetworkServiceDefault.self) { resolver in
            NetworkServiceDefault(config: resolver ~> (ApiDataNetworkConfig.self))
        }
        
        container.register(ApiDataNetworkConfig.self) { [urlConfiguration] resolver in
            ApiDataNetworkConfig(baseURL: URL(string: urlConfiguration.apiBaseURL)!, queryParameters: ["client_id": urlConfiguration.clientId])
        }
    }
}
