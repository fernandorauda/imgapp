//
//  UIImageView+Fetch.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Kingfisher
import UIKit

extension UIImageView {
    func fetchImage(from url: String?) {
        guard let stringUrl = url, let urlImage = URL(string: stringUrl) else {
            return
        }

        self.kf.indicatorType = .activity
        self.kf.setImage(with: urlImage)
    }
}
