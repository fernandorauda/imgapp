//
//  HomeCoordinator.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func homeCoordinatorDidNavigateToUser(_ username: String)
    func homeCoordinatorDidNavigateToImage(_ userId: String)
}

final class HomeCoordinator: Coordinator {
    // MARK: Properties

    var presenter: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []

    // MARK: - LifeCycle

    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }

    // MARK: - Start

    func start() {
        let homeViewController: HomeViewController = Injector
            .current
            .resolver
            .resolve(
                HomeViewController.self,
                argument: self as HomeCoordinatorDelegate
            ).unwrap()
        presenter.pushViewController(homeViewController, animated: true)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func homeCoordinatorDidNavigateToUser(_ username: String) {
        let viewController: UserViewController = Injector
            .current
            .resolver
            .resolve(
                UserViewController.self,
                argument: username as String
            ).unwrap()
        presenter.pushViewController(viewController, animated: true)
    }
    
    func homeCoordinatorDidNavigateToImage(_ id: String) {
        let viewController: ImageViewController = Injector
            .current
            .resolver
            .resolve(
                ImageViewController.self,
                argument: id as String
            ).unwrap()
        viewController.modalPresentationStyle = .fullScreen
        presenter.present(viewController, animated: true)
    }
}
