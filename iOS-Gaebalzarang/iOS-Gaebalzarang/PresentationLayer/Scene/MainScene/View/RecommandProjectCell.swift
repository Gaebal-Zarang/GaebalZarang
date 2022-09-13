//
//  RecommandProjectCell.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/09/02.
//

import UIKit

final class RecommandProjectCell: UICollectionViewCell {

    static let reuseIdentifier = "RecommandProjectCell"

    var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "projectThumbImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.text = "여행지 이동\n공유 서비스"
        return label
    }()

    private var dDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gzGreen
        label.text = "D-12"
        label.sizeToFit()
        return label
    }()

    private var hashTagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gzGray03
        label.font = .systemFont(ofSize: 16)
        label.sizeToFit()
        label.text = "#여행 #공유 #위치기반"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.prepareForReuse()
        thumbImageView.layer.cornerRadius = (frame.height * 0.85) / 2
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RecommandProjectCell {

    func configureLayout() {

        self.contentView.addSubviews(thumbImageView, titleLabel, dDayLabel, hashTagLabel)

        NSLayoutConstraint.activate([
            thumbImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            thumbImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            thumbImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            thumbImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.85),
            thumbImageView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.85)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: thumbImageView.leadingAnchor, constant: 11),
            titleLabel.bottomAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: -13),
            titleLabel.trailingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: -11)
        ])

        NSLayoutConstraint.activate([
            dDayLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            dDayLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dDayLabel.heightAnchor.constraint(equalToConstant: dDayLabel.intrinsicContentSize.height)
        ])

        NSLayoutConstraint.activate([
            hashTagLabel.topAnchor.constraint(equalTo: dDayLabel.bottomAnchor, constant: 1),
            hashTagLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            hashTagLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])

    }
}
