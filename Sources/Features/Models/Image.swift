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
    let urls: Url?
    let user: User?
    
    init(id: String?, likes: Int?, urls: Url?, user: User?) {
        self.id = id
        self.likes = likes
        self.urls = urls
        self.user = user
    }
    
    func numberOfLikes() -> String? {
        guard let numberOfLikes = likes else {
            return nil
        }
        return numberOfLikes == 0 ? "" : "\(numberOfLikes)"
    }
}
