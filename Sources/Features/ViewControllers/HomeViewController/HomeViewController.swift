//
//  ViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/6/21.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    // MARK: Components

    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
        
        setupBindings()
        viewModel.input.loadImages.onNext(())
    }

    // MARK: - Bindings

    private func setupBindings() {
        viewModel.output.images
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { images in
                print(images)
            }).disposed(by: disposeBag)
    }
}

