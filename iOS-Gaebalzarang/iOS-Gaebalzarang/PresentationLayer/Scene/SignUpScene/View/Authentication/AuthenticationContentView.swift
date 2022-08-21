//
//  AuthenticationContentView.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa

final class AuthenticationContentView: UIView {

    private var viewControllerFrame: CGRect = CGRect()
    private var isCodeMatched: Bool = false {
        willSet(newValue) {
            if newValue {
                let image = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
                self.checkCodeImageView.image = image
            }
        }
    }

    private lazy var phoneNumberTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "휴대폰 번호"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var receiveCodeButton: CustomNarrowButton = {
        let button = CustomNarrowButton(isEnabled: false)
        button.setTitle("인증 번호", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var confirmMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var authenticCodeTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "인증 번호 입력"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var checkCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gzGreen
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
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

    func setReceiveCodeButtonAction() -> Driver<Void> {
        return receiveCodeButton.rx.tap.asDriver()
    }

    func setPhoneNumberTexting() -> Driver<String?> {
        return phoneNumberTextField.rx.text.distinctUntilChanged().asDriver(onErrorJustReturn: nil)
    }

    func setAuthenticCode() -> Driver<String?> {
        return authenticCodeTextField.rx.text.distinctUntilChanged().asDriver(onErrorJustReturn: nil)
    }
}

extension AuthenticationContentView {

    func changeAuthenticButton(isEnabled: Bool) {
        receiveCodeButton.isEnabled = isEnabled
    }

    func changeAutenticCode(isValid: Bool) {
        isCodeMatched = isValid
    }

    func tappedReceiveCodeButton() {
        confirmMessageLabel.text = "인증번호가 발송됐습니다. (유효시간 1분)"
        confirmMessageLabel.textColor = .gzGreen
        configureExtraViewLayout()
    }
}

private extension AuthenticationContentView {

    func configureLayouts() {
        addSubviews(phoneNumberTextField, receiveCodeButton, confirmMessageLabel)

        let textFieldHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: viewControllerFrame)
        let phoneNumTopConstant = DesignGuide.estimateYAxisLength(origin: 21, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: topAnchor, constant: phoneNumTopConstant),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        let buttonWidth = DesignGuide.estimateXAxisLength(origin: 83, frame: viewControllerFrame)
        let buttonHeight = DesignGuide.estimateYAxisLength(origin: 26, frame: viewControllerFrame)
        let buttonTrailingConstant = DesignGuide.estimateXAxisLength(origin: 14, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            receiveCodeButton.trailingAnchor.constraint(equalTo: phoneNumberTextField.trailingAnchor, constant: -(buttonTrailingConstant)),
            receiveCodeButton.centerYAnchor.constraint(equalTo: phoneNumberTextField.centerYAnchor),
            receiveCodeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            receiveCodeButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        let labelHeight = DesignGuide.estimateYAxisLength(origin: 25, frame: viewControllerFrame)
        let labelLeadingConstant = DesignGuide.estimateXAxisLength(origin: 18, frame: viewControllerFrame)
        let labelTopConstant = DesignGuide.estimateYAxisLength(origin: 7, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            confirmMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: labelLeadingConstant),
            confirmMessageLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: labelTopConstant),
            confirmMessageLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }

    func configureCornerRadius() {
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: viewControllerFrame)
        let btnRound = DesignGuide.estimateNarrowViewCornerRadius(frame: viewControllerFrame)

        phoneNumberTextField.setCornerRound(value: viewRound)
        authenticCodeTextField.setCornerRound(value: viewRound)
        receiveCodeButton.setCornerRound(value: btnRound)
    }

    func configureExtraViewLayout() {
        addSubviews(authenticCodeTextField, checkCodeImageView)

        let authenticTopConstant = DesignGuide.estimateYAxisLength(origin: 20, frame: viewControllerFrame)
        let textFieldHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            authenticCodeTextField.topAnchor.constraint(equalTo: confirmMessageLabel.bottomAnchor, constant: authenticTopConstant),
            authenticCodeTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            authenticCodeTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            authenticCodeTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        let imageViewWidth = DesignGuide.estimateXAxisLength(origin: 19, frame: viewControllerFrame)
        let imageViewHeight = DesignGuide.estimateYAxisLength(origin: 22, frame: viewControllerFrame)
        let imageViewTrailingConstant = DesignGuide.estimateXAxisLength(origin: 19, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            checkCodeImageView.trailingAnchor.constraint(equalTo: authenticCodeTextField.trailingAnchor, constant: -(imageViewTrailingConstant)),
            checkCodeImageView.centerYAnchor.constraint(equalTo: authenticCodeTextField.centerYAnchor),
            checkCodeImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            checkCodeImageView.heightAnchor.constraint(equalToConstant: imageViewHeight)
        ])
    }
}
