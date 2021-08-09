//
//  Image.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation
import CoreData

class Image: NSObject, Decodable {
    let id: String?
    let likes: Int?
    let desc: String?
    let urls: Url?
    let user: User?
    let createdAt: String?
    
    init(id: String?, likes: Int?, urls: Url?, user: User?, desc: String?, createdAt: String?) {
        self.id = id
        self.likes = likes
        self.urls = urls
        self.user = user
        self.desc = desc
        self.createdAt = createdAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case likes
        case desc = "description"
        case urls
        case user
        case createdAt = "created_at"
    }
    
    func numberOfLikes() -> String? {
        guard let numberOfLikes = likes else {
            return nil
        }
        return numberOfLikes == 0 ? "" : "\(numberOfLikes)"
    }
}
