//
//  DataSource.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

class DataSource: NSObject, UICollectionViewDataSource {
    var sections: [Section]
    
    init(sections: [Section]) {
        self.sections = sections
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
}
