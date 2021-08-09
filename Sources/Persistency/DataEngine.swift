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
        
        
        let image = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        let currentItems = getItemsWithoutObserver()
        
        let existFavorite = currentItems.contains(where: { $0.id == item.id })
        
        image.setValue(item.id ?? "", forKeyPath: "id")
        image.setValue(item.likes ?? "", forKeyPath: "likes")
        image.setValue(item.user?.name ?? "", forKey: "userName")
        image.setValue(item.user?.profileImage?.medium ?? "", forKey: "userPhoto")
        image.setValue(item.urls?.small ?? "", forKey: "imageUrl")
        
        do {
            if existFavorite {
                try managedContext.save()
            } else {
                managedContext.delete(image)
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getItems() -> Observable<[Image]?> {
        Observable.create { observer in
            observer.onNext(getItemsWithoutObserver())
            return Disposables.create()
        }
    }
    
    func getItemsWithoutObserver() -> [Image] {
        var images: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ImageEntity")
        
        do {
            images = try managedContext.fetch(fetchRequest)
            return converToModel(with: images)
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
                urls: Url(regular: nil, full: object.value(forKeyPath: "imageUrl") as? String, small: nil, medium: nil),
                user: User(id: nil, username: nil, name: object.value(forKeyPath: "userName") as? String, profileImage: Url(regular: nil, full: nil, small: nil, medium: object.value(forKeyPath: "userPhoto") as? String))
            )
            images.append(image)
        }
        return images
    }
    
    
}
