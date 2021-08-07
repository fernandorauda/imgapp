//
//  APIEndpoint.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

struct APIEndpoints {
    
    static func getImages(with imageRequestDTO: ImagesRequestDTO) -> Endpoint<[Image]> {
        Endpoint(path: "photos",
                 method: .get,
                 queryParametersEncodable: imageRequestDTO
        )
    }
    
}
