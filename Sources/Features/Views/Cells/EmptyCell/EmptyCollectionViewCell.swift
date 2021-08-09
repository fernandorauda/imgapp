//
//  EmptyCollectionViewCell.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import UIKit

final class EmptyCollectionViewCell: UICollectionViewCell {
    // MARK: Components

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Añade tus imagenes favoritas y miralas en esta sección"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Layout

    private func configureLayout() {
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
}

extension EmptyCollectionViewCell: CellBindable {
    func bindViewModel(_ viewModel: Any) {}
}
