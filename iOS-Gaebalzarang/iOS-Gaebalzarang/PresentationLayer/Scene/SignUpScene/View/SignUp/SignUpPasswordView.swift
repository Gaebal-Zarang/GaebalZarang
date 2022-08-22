//
//  SignUPPasswordView.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxCocoa

final class SignUpPasswordView: UIView {

    private var viewControllerFrame: CGRect = CGRect()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "PW"
        textField.isSecureTextEntry = true
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        }
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var checkPasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "PW 재확인"
        textField.isSecureTextEntry = true
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        }
        textField.autocapitalizationType = .none
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

    func setCheckingPswValid() -> Driver<String?> {
        return passwordTextField.rx.text.distinctUntilChanged().asDriver(onErrorJustReturn: nil)
    }

    func setCheckingPswEqual() -> Driver<String?> {
        return checkPasswordTextField.rx.text.distinctUntilChanged().asDriver(onErrorJustReturn: nil)
    }
}

extension SignUpPasswordView {

    func checkValid(with isValid: Bool) {
        passwordTextField.layer.borderColor = isValid ? UIColor.gzGreen?.cgColor : UIColor.red.cgColor
    }

    func checkEqual(with isEqual: Bool) {
        isEqual ? configureValidText() : configureInvalidText()
    }

    func findAndResignFirstResponder() {
        self.subviews.forEach {
            guard !$0.isFirstResponder else {
                $0.resignFirstResponder()
                return
            }
        }
    }

    func reset() {
        passwordTextField.text = ""
        checkPasswordTextField.text = ""
        validCheckLabel.text = ""
        passwordTextField.layer.borderColor = UIColor.gzGray1?.cgColor

        findAndResignFirstResponder()
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
        let labelLeadingConstant = DesignGuide.estimateXAxisLength(origin: 18, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            validCheckLabel.topAnchor.constraint(equalTo: checkPasswordTextField.bottomAnchor, constant: labelTopConstant),
            validCheckLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: labelLeadingConstant),
            validCheckLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }

    func configureCornerRadius() {
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: viewControllerFrame)

        passwordTextField.setCornerRound(value: viewRound)
        checkPasswordTextField.setCornerRound(value: viewRound)
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
