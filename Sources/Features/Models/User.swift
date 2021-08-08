//
//  User.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

struct User: Decodable {
    let id: String?
    let username: String?
    let name: String?
    let profileImage: Url?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profileImage = "profile_image"
    }
}
