//
//  ViewController.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/6/21.
//

import UIKit
import RxSwift

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.loadImages.onNext(())
    }

    // MARK: - Bindings

    private func setupBindings() {
        viewModel.output.images
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] sections in
                self?.getDataSource(sectionType: sections)
            }).disposed(by: disposeBag)
    }
    
    private func registerCells() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing:ImageCollectionViewCell.self))
        collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: String(describing:LoadingCollectionViewCell.self))
    }
    
    // MARK: Configuration
    
    func getDataSource(sectionType: [SectionType]) {
        let section = sectionType.map { sectionControllerProvider.sectionController(for: $0) }
        dataSource.sections = section
            
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                return section[sectionIndex].layoutSection()
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
}

