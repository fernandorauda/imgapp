//
//  LoadingCollectionViewCell.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

final class LoadingCollectionViewCell: UICollectionViewCell {
    // MARK: Components

    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        activityIndicatorView.startAnimating()
    }

    // MARK: Layout

    private func configureLayout() {
        addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension LoadingCollectionViewCell: CellBindable {
    func bindViewModel(_ viewModel: Any) {}
}
