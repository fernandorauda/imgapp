//
//  Link.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation
import CoreData

struct Url: Decodable {
    let regular: String?
    let full: String?
    let small: String?
    let medium: String?
}

@objc(UrlObject)
public class UrlObject: NSManagedObject, Decodable {
    @NSManaged var regular: String?
    @NSManaged var full: String?
    @NSManaged var small: String?
    @NSManaged var medium: String?
    
    enum CodingKeys: String, CodingKey {
        case regular = "regular"
        case full = "full"
        case small = "small"
        case medium = "medium"
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(small ?? "blank", forKey: .small)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "UrlImageEntity", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            regular = try values.decode(String.self, forKey: .regular)
            full = try values.decode(String.self, forKey: .full)
            small = try values.decode(String.self, forKey: .small)
            medium = try values.decode(String.self, forKey: .medium)

        } catch {
            print ("error")
        }
    }
}
