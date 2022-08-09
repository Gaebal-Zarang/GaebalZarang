//
//  LoginSearchSignView.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit

final class LoginSearchSignView: UIView {

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var searchIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 비밀번호 찾기", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.gzGray3, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private var signUPButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.gzGray3, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private var slashLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gzGray3
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureLayouts()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginSearchSignView {

    func configureLayouts() {
        addSubview(stackView)
        stackView.addArrangedSubviews(searchIDButton, slashLabel, signUPButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
