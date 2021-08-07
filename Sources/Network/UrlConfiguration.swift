//
//  UrlConfiguration.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

final class UrlConfiguration {
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
