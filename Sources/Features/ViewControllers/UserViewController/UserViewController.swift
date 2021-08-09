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

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var bioLabel: UILabel!
    @IBOutlet private var numberOfPhotosLabel: UILabel!
    @IBOutlet private var numberOfCollectionsLabel: UILabel!
    @IBOutlet private var numberOfLikesLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationStackview: UIStackView!
    
    // MARK: - Properties

    private let viewModel: UserViewModel
    private let disposeBag = DisposeBag()
    
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

        scrollView.isHidden = true
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
        
        viewModel.output.bio
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: bioLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.numberOfLikes
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: numberOfLikesLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.numberOfPhotos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: numberOfPhotosLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.numberOfCollections
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: numberOfCollectionsLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.location
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.rx.location)
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
    }
    
    func loadProfileImage(url: String) {
        photoImageView.fetchImage(from: url)
    }
    
    func loadLocation(with location: String) {
        if location == "" {
            locationStackview.isHidden = true
        } else {
            locationLabel.text = location
        }
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
        scrollView.isHidden = false
    }
}

extension Reactive where Base: UserViewController {
    internal var photoLoad: Binder<String> {
        return Binder(self.base, binding: { base, urlString in
            base.loadProfileImage(url: urlString)
        })
    }
    
    internal var isLoading: Binder<Bool> {
        return Binder(self.base) { base, isLoading in
            if !isLoading {
                base.stopActivity()
            }
        }
    }
    
    internal var location: Binder<String> {
        return Binder(self.base) { base, location in
            base.loadLocation(with: location)
        }
    }

}
