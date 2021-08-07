//
//  Coordinator.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var presenter: UINavigationController { get }
    var parentCoordinator: Coordinator? { get }
    var childCoordinators: [Coordinator] { get set }

    func start()
    func end()
    func childDidFinish(_ child: Coordinator?)
    func addChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func end() {
        parentCoordinator?.childDidFinish(self)
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
        }
    }

    func presentCoordinator<CoordinatorType: Coordinator>(_ type: CoordinatorType.Type) {
        let coordinator: CoordinatorType = Injector.current.resolver.resolve(
            type,
            arguments: presenter,
            self as Coordinator
        ).unwrap()

        coordinator.start()
        addChildCoordinator(coordinator)
    }
}

