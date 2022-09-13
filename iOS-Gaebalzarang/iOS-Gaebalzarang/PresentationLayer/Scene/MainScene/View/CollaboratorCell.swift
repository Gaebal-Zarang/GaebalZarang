//
//  CollaboratorCell.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/09/02.
//

import UIKit

final class CollaboratorCell: UICollectionViewCell {
    // TODO: 임시 이미지/텍스트 변경 필요

    static let reuseIdentifier = "CollaboratorCell"

    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "projectThumbImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Chez"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.sizeToFit()
        return label
    }()

    private var badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gzGreen
        imageView.image = .init(systemName: "staroflife.fill")
        return imageView
    }()

    private var positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.text = "iOS 개발자"
        label.textColor = UIColor.gzGray4
        label.sizeToFit()
        return label
    }()

    private var viewDetailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .gzGreen
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.prepareForReuse()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension CollaboratorCell {

    func configureLayout() {

        self.contentView.addSubviews(profileImageView, nameLabel, badgeImageView, positionLabel, viewDetailsButton)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 26),
            profileImageView.widthAnchor.constraint(equalToConstant: 62),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 11)
        ])

        NSLayoutConstraint.activate([
            badgeImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            badgeImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 6),
            badgeImageView.widthAnchor.constraint(equalToConstant: 13),
            badgeImageView.heightAnchor.constraint(equalToConstant: 13)
        ])

        NSLayoutConstraint.activate([
            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            positionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -7)
        ])

        NSLayoutConstraint.activate([
            viewDetailsButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            viewDetailsButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -37),
            viewDetailsButton.widthAnchor.constraint(equalToConstant: 42),
            viewDetailsButton.heightAnchor.constraint(equalToConstant: 42)
        ])

    }
}
