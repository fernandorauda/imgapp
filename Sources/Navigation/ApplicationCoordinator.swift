//
//  ApplicationCoordinator.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    // MARK: - Properties

    let window: UIWindow

    var presenter: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []

    // MARK: LifeCycle

    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }

    // MARK: Start

    func start() {
        
    }
}
