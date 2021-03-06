//
//  LikesViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import RxSwift
import UIKit

final class LikesViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var collectionView: UICollectionView!

    // MARK: Components

    private let viewModel: LikesViewModel
    private let disposeBag = DisposeBag()
    private let sectionControllerProvider: SectionControllerProvider
    private var dataSource = DataSource(sections: [])

    // MARK: - LifeCycle

    init(viewModel: LikesViewModel, sectionControllerProvider: SectionControllerProvider) {
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
        
        navigationController?.navigationBar.topItem?.title = "Likes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        registerCells()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImages()
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
        collectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self)
        )
        collectionView.register(
            EmptyCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: EmptyCollectionViewCell.self)
        )
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
        collectionView.reloadData()
    }

    // MARK: - Actions

    override func didMarkFavorite(with image: Image) {
        viewModel.input.sendFavorite.onNext(image)
    }
    
    func loadImages() {
        viewModel.input.loadImages.onNext(())
    }
}


extension Reactive where Base: LikesViewController {
    internal var sections: Binder<[SectionType]> {
        return Binder(self.base, binding: { base, sections in
            base.getDataSource(sectionType: sections)
        })
    }
    
    internal var favorite: Binder<Void> {
        return Binder(self.base, binding: { base, _ in
            base.loadImages()
        })
    }

}
