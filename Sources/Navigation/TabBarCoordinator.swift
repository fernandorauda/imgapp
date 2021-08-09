//
//  TabBarCoordinator.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarItem)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarItem?
}

final class TabBarCoordinator: Coordinator {
    // MARK: Properties

    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    var parentCoordinator: Coordinator?
    var tabBarController: UITabBarController

    // MARK: - LifeCycle

    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
        self.tabBarController = .init()
    }

    // MARK: - Start

    func start() {
        let pages: [TabBarItem] = [.home, .likes]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }

    // MARK: - TabBar Items

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
  
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarItem.home.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        
        presenter.viewControllers = [tabBarController]
    }

    private func getTabController(_ item: TabBarItem) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: nil,
                                                     image: item.itemImageValue(),
                                                     tag: item.pageOrderNumber())

        switch item {
        case .home:
            let coordinator: HomeCoordinator = Injector.current.resolver.resolve(
                HomeCoordinator.self,
                arguments: navController, self as Coordinator
            ).unwrap()
            coordinator.start()
            addChildCoordinator(coordinator)
            
        case .likes:
            let likesViewController: LikesViewController = Injector.current.resolver.resolve(LikesViewController.self).unwrap()
            navController.pushViewController(likesViewController, animated: true)
        }
        
        return navController
    }

    func currentPage() -> TabBarItem? { TabBarItem.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarItem) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarItem.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}
