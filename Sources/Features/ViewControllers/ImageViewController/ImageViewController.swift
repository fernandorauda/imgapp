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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
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
        
        prepareViews()
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
        
        viewModel.output.mainPhoto
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.rx.mainPhotoLoad)
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
        
        viewModel.output.date
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func prepareViews() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0

        scrollView.contentSize = .init(width: 2000, height: 2000)
        contentView.isHidden = true
    }
    
    func loadProfileImage(url: String) {
        userImage.fetchImage(from: url)
    }
    
    func loadMainImage(url: String) {
        imageView.fetchImage(from: url)
    }
    
    func endLoadContent() {
        contentView.isHidden = false
    }
    
    @IBAction func exitAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension Reactive where Base: ImageViewController {
    internal var photoLoad: Binder<String> {
        return Binder(self.base, binding: { base, urlString in
            base.loadProfileImage(url: urlString)
        })
    }
    
    internal var mainPhotoLoad: Binder<String> {
        return Binder(self.base, binding: { base, urlString in
            base.loadMainImage(url: urlString)
        })
    }
    
    internal var isLoading: Binder<Bool> {
        return Binder(self.base) { base, isLoading in
            if !isLoading {
                base.endLoadContent()
            }
        }
    }
    
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func updateZoomFor(size: CGSize){
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let scale = min(widthScale,heightScale)
        scrollView.minimumZoomScale = scale
    }
}
