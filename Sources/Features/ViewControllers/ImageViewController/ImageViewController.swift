//
//  ImageViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/9/21.
//

import UIKit

class ImageViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: UserViewModel
    
    // MARK: LifeCycle
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
