//
//  PaginatorState.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import Foundation

final class PaginatorState {
    var hasNext: Bool
    var isLoading: Bool
    var currentPage: Int
    var isEmpty: Bool

    init(hasNext: Bool, isLoading: Bool, currentPage: Int, isEmpty: Bool) {
        self.hasNext = hasNext
        self.isLoading = isLoading
        self.currentPage = currentPage
        self.isEmpty = isEmpty
    }
}
