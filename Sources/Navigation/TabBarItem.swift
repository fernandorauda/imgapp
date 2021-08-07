//
//  TabBarItem.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

enum TabBarItem {
    case home
    case likes

    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .likes
        default:
            return nil
        }
    }
    
    func itemImageValue() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "ico_home_tab")
        case .likes:
            return UIImage(named: "ico_likes_tab")
        }
    }
    
    func itemNavTitle() -> String? {
        switch self {
        case .home:
            return "PHOTOS"
        case .likes:
            return "LIKES"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .likes:
            return 1
        }
    }

    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}
