//
//  Optional+Unwrap.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Foundation

extension Optional {
    func unwrap<Type: AnyObject>() -> Type {
        guard let type = self as? Type else { fatalError("Unable to downcast to \(Type.self)") }
        return type
    }
}
