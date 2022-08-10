//
//  SignUPPasswordView.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit

final class SignUpPasswordView: UIView {

    private var viewControllerFrame: CGRect = CGRect()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "PW"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var checkPasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "PW 재확인"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var validCheckLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }

    convenience init(with viewControllerFrame: CGRect) {
        self.init()
        self.viewControllerFrame = viewControllerFrame
        configureLayouts()
        configureCornerRadius()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func validCheck(with isValid: Bool) {
        isValid ? configureValidText() : configureInvalidText()
    }
}

private extension SignUpPasswordView {

    func configureLayouts() {
        addSubviews(passwordTextField, checkPasswordTextField, validCheckLabel)

        let textFieldHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: topAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        let checkPswFieldTopConstant = DesignGuide.estimateYAxisLength(origin: 14, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            checkPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: checkPswFieldTopConstant),
            checkPasswordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        let labelHeight = DesignGuide.estimateYAxisLength(origin: 25, frame: viewControllerFrame)
        let labelTopConstant = DesignGuide.estimateYAxisLength(origin: 7, frame: viewControllerFrame)
        let labelLeadingConstant = DesignGuide.estimateXAxisLength(origin: 43, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            validCheckLabel.topAnchor.constraint(equalTo: checkPasswordTextField.bottomAnchor, constant: labelTopConstant),
            validCheckLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: labelLeadingConstant),
            validCheckLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }

    func configureCornerRadius() {
        let textFieldRound = DesignGuide.estimateCornerRadius(origin: 50, frame: viewControllerFrame)

        passwordTextField.setCornerRound(value: textFieldRound)
        checkPasswordTextField.setCornerRound(value: textFieldRound)
    }

    func configureValidText() {
        validCheckLabel.text = "패스워드가 일치합니다."
        validCheckLabel.textColor = .gzGreen
    }

    func configureInvalidText() {
        validCheckLabel.text = "패스워드가 일치하지 않습니다."
        validCheckLabel.textColor = .red
    }
}
