//
//  ImageCellViewModel.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

final class ImageCellViewModel: CollectionCellViewModel {
    let image: Image
    
    init(image: Image) {
        self.image = image
    }
    
    var imageUrl: String? {
        image.urls?.full
    }
    
    var profileUrl: String? {
        image.user?.profileImage?.medium
    }
    
    var userName: String? {
        image.user?.name
    }
    
    var likes: String? {
        image.numberOfLikes()
    }
    
}
