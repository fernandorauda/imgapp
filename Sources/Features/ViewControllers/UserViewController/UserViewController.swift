//
//  UserViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit
import RxSwift
import Kingfisher

class UserViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    @IBOutlet weak var numberOfCollectionsLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - Properties

    private let viewModel: UserViewModel
    private let disposeBag = DisposeBag()
    
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

        setupBindings()
        viewModel.input.loadUser.onNext(())
    }

    private func setupBindings() {
        viewModel.output.name
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.photo
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.rx.photoLoad)
            .disposed(by: disposeBag)
    }
    
    func loadProfileImage(url: String) {
        photoImageView.fetchImage(from: url)
    }
}

extension Reactive where Base: UserViewController {
    internal var photoLoad: Binder<String> {
        return Binder(self.base, binding: { base, urlString in
            base.loadProfileImage(url: urlString)
        })
    }

}
