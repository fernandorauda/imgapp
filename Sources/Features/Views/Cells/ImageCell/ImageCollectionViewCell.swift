//
//  ImageCollectionViewCell.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    private lazy var view: UIView = {
        UIView()
    }()
    
    // MARK: Initializacion

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialized()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialized()
    }
    
    private func initialized() {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

extension ImageCollectionViewCell: CellBindable {
    func bindViewModel(_ viewModel: Any) {
    }
}
