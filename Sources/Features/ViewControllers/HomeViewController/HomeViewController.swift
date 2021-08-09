//
//  ViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/6/21.
//

import RxSwift
import UIKit

final class HomeViewController: UIViewController {
    // MARK: IBOutlets

    @IBOutlet private var collectionView: UICollectionView!

    // MARK: Components

    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    private let sectionControllerProvider: SectionControllerProvider
    private var dataSource = DataSource(sections: [])

    // MARK: - LifeCycle

    init(viewModel: HomeViewModel, sectionControllerProvider: SectionControllerProvider) {
        self.viewModel = viewModel
        self.sectionControllerProvider = sectionControllerProvider
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
        
        registerCells()
        setupBindings()
        
        viewModel.input.restartPagination.onNext(())
        viewModel.input.loadImages.onNext(())
        collectionView.delegate = self

    }

    // MARK: - Bindings

    private func setupBindings() {
        viewModel.output.sections
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.rx.sections)
            .disposed(by: disposeBag)
        
        viewModel.output.favorite
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.rx.favorite)
            .disposed(by: disposeBag)
    }
    
    private func registerCells() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing:ImageCollectionViewCell.self))
        collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: String(describing:LoadingCollectionViewCell.self))
    }
    
    // MARK: Configuration
    
    func getDataSource(sectionType: [SectionType]) {
        let sections = sectionType.map { sectionControllerProvider.sectionController(for: $0) }
        dataSource.sections = sections
            
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                return sections[sectionIndex].layoutSection()
        }
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = dataSource
    }
    
    // MARK: - Actions
    
    override func didMarkFavorite(with image: Image) {
        viewModel.input.sendFavorite.onNext(image)
    }
    
    override func didOpenUserDetail(with username: String) {
        viewModel.navigateToUser(username: username)
    }
    
    override func didOpenImageDetail(with id: String) {
        viewModel.navigateToImage(id: id)
    }
}

// MARK: ScrollViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let distance = collectionView.distance(
            targetContentOffsetPointee: targetContentOffset
        )

        if distance < 300 {
            viewModel.input.loadImages.onNext(())
        }
    }
}

extension Reactive where Base: HomeViewController {
    internal var sections: Binder<[SectionType]> {
        return Binder(self.base, binding: { base, sections in
            base.getDataSource(sectionType: sections)
        })
    }
    
    internal var favorite: Binder<Void> {
        return Binder(self.base, binding: { _, _ in
        })
    }

}
