//
//  ImageResponseDTO.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

struct ImageResponseDTO: Decodable {
    let totalPages: Int?
    let results: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case results
    }
}
