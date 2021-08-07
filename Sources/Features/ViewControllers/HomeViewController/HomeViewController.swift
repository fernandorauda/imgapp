//
//  ViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/6/21.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - LifeCycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

