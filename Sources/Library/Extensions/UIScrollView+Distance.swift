//
//  UIScrollView+Distance.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

extension UIScrollView {
    func distance(targetContentOffsetPointee: UnsafeMutablePointer<CGPoint>) -> CGFloat {
        let scrollViewHeight = contentSize.height
        let offset = targetContentOffsetPointee.pointee.y + bounds.height
        let distance = scrollViewHeight - offset
        return distance
    }
}
