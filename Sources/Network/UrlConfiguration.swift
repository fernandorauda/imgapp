//
//  UrlConfiguration.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

final class UrlConfiguration {
    lazy var clientId: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ClientId") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
