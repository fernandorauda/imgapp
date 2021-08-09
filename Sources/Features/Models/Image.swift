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

@objc(ImageObject)
public class ImageObject: NSManagedObject, Decodable {
    @NSManaged var id: String?
    @NSManaged var likes: NSNumber?
    @NSManaged var urls: UrlObject?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case likes = "likes"
        case urls = "urls"
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id ?? "blank", forKey: .id)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ImageEntity", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try values.decode(String.self, forKey: .id)
            likes = NSNumber(value: try values.decode(Int.self, forKey: .likes))
            urls = try values.decode(UrlObject.self, forKey: .urls)
        } catch {
            print ("error")
        }
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
