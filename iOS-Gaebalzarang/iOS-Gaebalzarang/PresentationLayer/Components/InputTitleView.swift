//
//  CustomTitleLabel.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/10.
//

import UIKit

class InputTitleView: UIView {

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var optionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubviews(titleLabel, optionLabel)
        configureLayout()
    }

    init(text: String, isRequire: Bool = false) {
        super.init(frame: .zero)
        stackView.addArrangedSubviews(titleLabel, optionLabel)
        self.addSubview(stackView)
        configureLayout()
        titleLabel.text = text
        optionLabel.text = isRequire ? "*필수" : "*선택"
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

}

private extension InputTitleView {

    func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

    }
}
