//
//  ObservableType+Void.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import RxSwift

extension ObservableType {
    func toVoid() -> Observable<Void> {
        asObservable().map { _  in () }
    }
}
