//
//  ImageCollectionViewCell.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/7/21.
//

import Kingfisher
import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
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
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ico_like"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var numberOfLikesLabel: UILabel = {
        let label = UILabel()
        label.shadow()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Components
    
    var viewModel: ImageCellViewModel!

    // MARK: Initializacion

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialized()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialized()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        nameUserLabel.text = nil
        profileImage.image = nil
        viewModel = nil
    }
    
    private func initialized() {
        contentView.addSubview(imageView)
        contentView.addSubview(profileImage)
        contentView.addSubview(nameUserLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(numberOfLikesLabel)
        
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
            nameUserLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -8),
            
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            favoriteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 22),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            
            numberOfLikesLabel.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 16),
            numberOfLikesLabel.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor),
            numberOfLikesLabel.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    
    func configure(url: String?, profileUrl: String?, nameUser: String?, likes: String?) {
        imageView.fetchImage(from: url)
        profileImage.fetchImage(from: profileUrl)
        nameUserLabel.text = nameUser
        numberOfLikesLabel.text = likes
    }
    
    // MARK: - Actions
    
    @objc private func favoriteAction() {
        next?.didMarkFavorite(with: viewModel.image)
    }
}

extension ImageCollectionViewCell: CellBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ImageCellViewModel else { return }
        self.viewModel = viewModel
        configure(
            url: viewModel.imageUrl,
            profileUrl: viewModel.profileUrl,
            nameUser: viewModel.userName,
            likes: viewModel.likes
        )
    }
}
