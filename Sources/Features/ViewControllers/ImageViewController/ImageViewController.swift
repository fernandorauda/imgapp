//
//  ImageViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/9/21.
//

import RxSwift
import UIKit

class ImageViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties

    private let viewModel: ImageViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: LifeCycle
    
    init(viewModel: ImageViewModel) {
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
        setupBindings()
        viewModel.input.loadImage.onNext(())
    }
    
    private func setupBindings() {
        
        viewModel.output.userPhoto
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.rx.photoLoad)
            .disposed(by: disposeBag)
        
        viewModel.output.userName
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: userNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.desc
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func loadProfileImage(url: String) {
        userImage.fetchImage(from: url)
    }
}

extension Reactive where Base: ImageViewController {
    internal var photoLoad: Binder<String> {
        return Binder(self.base, binding: { base, urlString in
            base.loadProfileImage(url: urlString)
        })
    }
}
