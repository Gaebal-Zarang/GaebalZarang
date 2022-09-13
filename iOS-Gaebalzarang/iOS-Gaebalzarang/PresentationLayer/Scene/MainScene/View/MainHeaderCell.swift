//
//  MainHeaderCell.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/09/10.
//

import UIKit

final class MainHeaderCell: UICollectionViewCell {

    static let reuseIdentifier: String = "MainHeaderCell"

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "현재 참여 중인\n방이 없습니다."
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gzGreen
        configureLayout()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainHeaderCell {

    func configureLayout() {
        self.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 26),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -22)
        ])

    }
}
