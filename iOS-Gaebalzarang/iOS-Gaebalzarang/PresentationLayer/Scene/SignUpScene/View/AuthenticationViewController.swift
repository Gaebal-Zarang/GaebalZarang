//
//  AuthenticationViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa

// TODO: 인증 번호, 확인 버튼 isEnable false로 바꾸고 값 입력시 true로 변경
final class AuthenticationViewController: UIViewController {

    let disposeBag = DisposeBag()

    private lazy var phoneNumberTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "휴대폰 번호"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var receiveCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증 번호", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gzGray2
        button.clipsToBounds = true
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

    private lazy var checkCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증 확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gzGray2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var nextButton: CustomButton = {
        let nextButtonRound = DesignGuide.estimateCornerRadius(origin: 50, frame: view.frame)
        let button = CustomButton()
        button.setTitle("다음", for: .normal)
        button.setCornerRound(value: nextButtonRound)
        // TODO: 유효성 검사 구현 시, isEnabled false로 변경
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        configureCornerRadius()
        configureInnerActionBinding()
    }
}

private extension AuthenticationViewController {

    func configureLayouts() {
        view.addSubviews(phoneNumberTextField, receiveCodeButton, confirmMessageLabel, authenticCodeTextField, checkCodeButton, nextButton)

        let viewWidth = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)
        let textFieldHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)
        let phoneNumTopConstant = DesignGuide.estimateYAxisLength(origin: 21, frame: view.frame)

        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: phoneNumTopConstant),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: viewWidth),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        let buttonWidth = DesignGuide.estimateXAxisLength(origin: 83, frame: view.frame)
        let buttonHeight = DesignGuide.estimateYAxisLength(origin: 26, frame: view.frame)
        let buttonTrailingConstant = DesignGuide.estimateXAxisLength(origin: 14, frame: view.frame)

        NSLayoutConstraint.activate([
            receiveCodeButton.trailingAnchor.constraint(equalTo: phoneNumberTextField.trailingAnchor, constant: -(buttonTrailingConstant)),
            receiveCodeButton.centerYAnchor.constraint(equalTo: phoneNumberTextField.centerYAnchor),
            receiveCodeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            receiveCodeButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        let labelHeight = DesignGuide.estimateYAxisLength(origin: 25, frame: view.frame)
        let labelLeadingConstant = DesignGuide.estimateXAxisLength(origin: 50, frame: view.frame)
        let labelTopConstant = DesignGuide.estimateYAxisLength(origin: 7, frame: view.frame)

        NSLayoutConstraint.activate([
            confirmMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelLeadingConstant),
            confirmMessageLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: labelTopConstant),
            confirmMessageLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])

        let authenticTopConstant = DesignGuide.estimateYAxisLength(origin: 20, frame: view.frame)

        NSLayoutConstraint.activate([
            authenticCodeTextField.topAnchor.constraint(equalTo: confirmMessageLabel.bottomAnchor, constant: authenticTopConstant),
            authenticCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authenticCodeTextField.widthAnchor.constraint(equalToConstant: viewWidth),
            authenticCodeTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        NSLayoutConstraint.activate([
            checkCodeButton.trailingAnchor.constraint(equalTo: authenticCodeTextField.trailingAnchor, constant: -(buttonTrailingConstant)),
            checkCodeButton.centerYAnchor.constraint(equalTo: authenticCodeTextField.centerYAnchor),
            checkCodeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            checkCodeButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        let nextButtonHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)
        let nextButtonTopConstant = DesignGuide.estimateYAxisLength(origin: 431, frame: view.frame)

        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: nextButtonTopConstant),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: viewWidth),
            nextButton.heightAnchor.constraint(equalToConstant: nextButtonHeight)
        ])
    }

    func configureCornerRadius() {
        let textFieldRound = DesignGuide.estimateCornerRadius(origin: 50, frame: view.frame)
        let buttonRound = DesignGuide.estimateCornerRadius(origin: 26, frame: view.frame)

        phoneNumberTextField.setCornerRound(value: textFieldRound)
        authenticCodeTextField.setCornerRound(value: textFieldRound)
        receiveCodeButton.layer.cornerRadius = buttonRound
        checkCodeButton.layer.cornerRadius = buttonRound
    }

    func configureInnerActionBinding() {
        receiveCodeButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.tappedReceiveCodeButton()
            }
            .disposed(by: disposeBag)

        checkCodeButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in

            }
            .disposed(by: disposeBag)
    }

    func tappedReceiveCodeButton() {
        confirmMessageLabel.text = "인증번호가 발송됐습니다. (유효시간 1분)"
        confirmMessageLabel.textColor = .gzChacoal
    }
}
