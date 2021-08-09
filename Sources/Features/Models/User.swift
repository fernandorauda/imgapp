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
    let totalLikes: Int?
    let totalPhotos: Int?
    let totalCollections: Int?
    let location: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case location
        case bio
        case profileImage = "profile_image"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
    }
}
