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
    
    init(id: String?, likes: Int?, urls: Url?, user: User?) {
        self.id = id
        self.likes = likes
        self.urls = urls
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case likes
        case desc = "description"
        case urls
        case user
    }
    
    func numberOfLikes() -> String? {
        guard let numberOfLikes = likes else {
            return nil
        }
        return numberOfLikes == 0 ? "" : "\(numberOfLikes)"
    }
}
