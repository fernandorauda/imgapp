//
//  UIResponder+Extension.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

extension UIResponder {
    @objc func didMarkFavorite(with image: Image) {
        next?.didMarkFavorite(with: image)
    }
    
    @objc func didOpenUserDetail(with username: String) {
        next?.didOpenUserDetail(with: username)
    }
    
    @objc func didOpenImageDetail(with id: String) {
        next?.didOpenImageDetail(with: id)
    }

}
