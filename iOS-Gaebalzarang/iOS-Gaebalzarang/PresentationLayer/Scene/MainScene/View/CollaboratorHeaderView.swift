//
//  CollaboratorHeaderView.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/09/06.
//

import UIKit

final class CollaboratorHeaderView: UICollectionReusableView {

    static let reuseIdentifier: String = "CollaboratorHeaderView"

    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "추천 협업자"
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CollaboratorHeaderView {

    func configureLayout() {
        self.addSubview(title)

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
