//
//  Image.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

struct Image: Decodable {
    let id: String?
    let likes: Int?
    let urls: Url?
    let user: User?
}

