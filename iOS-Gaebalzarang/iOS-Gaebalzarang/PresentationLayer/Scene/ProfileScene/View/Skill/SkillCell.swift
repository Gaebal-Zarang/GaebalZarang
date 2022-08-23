//
//  SkillCell.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/22.
//

import UIKit

class SkillCell: UICollectionViewCell {

    static let reuseIdentifier = "SkillCell"

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.backgroundColor = .gzYellow
        self.prepareForReuse()
        self.clipsToBounds = true
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(text: String) {
        label.text = text
    }
}

private extension SkillCell {

    func configureLayout() {
        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

    }
}
