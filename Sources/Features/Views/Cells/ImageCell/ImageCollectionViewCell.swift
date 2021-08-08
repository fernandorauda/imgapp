//
//  ImageCollectionViewCell.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Kingfisher
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Components

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameUserLabel: UILabel = {
        let label = UILabel()
        label.shadow()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(imageView)
        contentView.addSubview(profileImage)
        contentView.addSubview(nameUserLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 32),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            
            nameUserLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            nameUserLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor ,constant: 8),
            nameUserLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    
    func configure(url: String?, profileUrl: String?, nameUser: String?) {
        imageView.fetchImage(from: url)
        profileImage.fetchImage(from: profileUrl)
        nameUserLabel.text = nameUser
    }
}

extension ImageCollectionViewCell: CellBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ImageCellViewModel else { return }
        configure(
            url: viewModel.imageUrl,
            profileUrl: viewModel.profileUrl,
            nameUser: viewModel.userName
        )
    }
}
