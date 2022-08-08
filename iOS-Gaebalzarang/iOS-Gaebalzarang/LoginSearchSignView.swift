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
        button.setTitleColor(UIColor(red: 173 / 255, green: 173 / 255, blue: 173 / 255, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private var signUPButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(UIColor(red: 173 / 255, green: 173 / 255, blue: 173 / 255, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private var slashLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 173 / 255, green: 173 / 255, blue: 173 / 255, alpha: 1.0)
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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
//        addSubviews(searchIDButton, slashLabel, signUPButton)
//
//        NSLayoutConstraint.activate([
//            searchIDButton.topAnchor.constraint(equalTo: topAnchor),
//            searchIDButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            searchIDButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//        ])
//
//        NSLayoutConstraint.activate([
//            slashLabel.topAnchor.constraint(equalTo: topAnchor),
//            slashLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//            slashLabel.leadingAnchor.constraint(equalTo: searchIDButton.trailingAnchor, constant: 5)
//        ])
//
//        NSLayoutConstraint.activate([
//            signUPButton.topAnchor.constraint(equalTo: topAnchor),
//            signUPButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            signUPButton.leadingAnchor.constraint(equalTo: slashLabel.trailingAnchor, constant: 5),
//            signUPButton.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
    }
}
