//
//  DataEngine.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Foundation
import CoreData

protocol DataEngine {
    func save(item: Image)
    //func getItems() -> [Image]
}

class DataManager {
    let engine: DataEngine
    
    init(engine: DataEngine) {
        self.engine = engine
    }
    
    func save(item: Image) {
        engine.save(item: item)
    }
    
    //func getItems() -> [Image] {
        //engine.getItems()
    //}
}

struct CoreDataEngine: DataEngine {
    func save(item: Image) {
        
    }
    
    //func getItems() -> [Image] {
        
    //}
    
    
}
