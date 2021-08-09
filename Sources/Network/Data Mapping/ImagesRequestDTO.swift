//
//  ImagesRequestDTO.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

struct ImagesRequestDTO: Encodable {
    let page: Int
    let perPage: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
    }
}
