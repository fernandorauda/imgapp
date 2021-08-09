//
//  UIView+CornerRadius.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

@IBDesignable
public extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }

        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }

        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }

        set (color) {
            self.layer.borderColor = color?.cgColor
        }
    }
}
