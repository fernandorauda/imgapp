//
//  UILabel+Shadow.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

public extension UILabel {
    func shadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
    }
}
