//
//  DataEngine.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import CoreData
import RxSwift
import UIKit

protocol DataEngine {
    func save(item: Image)
    func getItems() -> Observable<[Image]?>
}

class DataManager {
    let engine: DataEngine
    
    init(engine: DataEngine) {
        self.engine = engine
    }
    
    func save(item: Image) {
        engine.save(item: item)
    }
    
    func getItems() -> Observable<[Image]?> {
        engine.getItems()
    }
}

struct CoreDataEngine: DataEngine {
    func save(item: Image) {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =
          NSEntityDescription.entity(forEntityName: "ImageEntity",
                                     in: managedContext)!
        
        let currentItems = getItemsWithoutObserver()
        
        let existFavorite = currentItems.first(where: { $0.value(forKeyPath: "id") as? String == item.id })
        
        if let existFavorite = existFavorite {
            managedContext.delete(existFavorite)
        } else {
            let image = NSManagedObject(
                entity: entity,
                insertInto: managedContext
            )
            image.setValue(item.id ?? "", forKeyPath: "id")
            image.setValue(item.likes ?? "", forKeyPath: "likes")
            image.setValue(item.user?.username ?? "", forKey: "username")
            image.setValue(item.user?.profileImage?.medium ?? "", forKey: "userPhoto")
            image.setValue(item.urls?.small ?? "", forKey: "imageUrl")
            image.setValue(item.user?.id ?? "", forKey: "userId")
            image.setValue(item.user?.name, forKey: "name")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getItems() -> Observable<[Image]?> {
        Observable.create { observer in
            let objects = getItemsWithoutObserver()
            let models = converToModel(with: objects)
            observer.onNext(models)
            return Disposables.create()
        }
    }
    
    func getItemsWithoutObserver() -> [NSManagedObject] {
        var images: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ImageEntity")
        
        do {
            images = try managedContext.fetch(fetchRequest)
            return images
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func converToModel(with objects: [NSManagedObject]) -> [Image] {
        var images: [Image] = []
        for object in objects {
            let image = Image(
                id: object.value(forKeyPath: "id") as? String,
                likes: object.value(forKeyPath: "likes") as? Int,
                urls: Url(
                    regular: nil,
                    full: object.value(forKeyPath: "imageUrl") as? String,
                    small: nil,
                    medium: nil),
                user: User(
                    id: object.value(forKeyPath: "userId") as? String,
                    username: object.value(forKeyPath: "username") as? String,
                    name: object.value(forKeyPath: "name") as? String,
                    profileImage: Url(
                        regular: nil,
                        full: nil,
                        small: nil,
                        medium: object.value(forKeyPath: "userPhoto") as? String),
                    totalLikes: nil,
                    totalPhotos: nil,
                    totalCollections: nil,
                    location: nil,
                    bio: nil),
                desc: nil,
                createdAt: nil
            )
            images.append(image)
        }
        return images
    }
    
    
}
