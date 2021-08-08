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
}
