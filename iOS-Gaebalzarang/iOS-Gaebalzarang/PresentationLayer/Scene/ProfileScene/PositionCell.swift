//
//  PositionCell.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/10.
//

import UIKit

class PositionCell: UICollectionViewCell {

    override var isSelected: Bool {
            didSet {
                isSelected ? configureEnabledSetting() : configureDisabledSetting()
            }
    }

    static let reuseIdentifier = "PositionCell"

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gzGray2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.prepareForReuse()
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gzGreen?.cgColor
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(text: String) {
        label.text = text
    }
}

private extension PositionCell {

    func configureLayout() {
        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

    }

    func configureEnabledSetting() {
        backgroundColor = .gzGreen
        layer.borderWidth = 0
        self.label.textColor = .white
    }

    func configureDisabledSetting() {
        backgroundColor = .white
        layer.borderWidth = 1
        self.label.textColor = UIColor.gzGreen
    }
}
