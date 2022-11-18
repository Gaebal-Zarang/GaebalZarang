//
//  AuthenticationViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Then
import SnapKit

final class AuthenticationViewController: UIViewController {

    private let verticalStackView = UIStackView().then {
        $0.spacing = 7
        $0.axis = .vertical
        $0.distribution = .fill
    }

    private let phoneTextField = CustomTextField().then {
        $0.placeholder = "휴대폰 번호"
        $0.setPlaceHolder()
    }

    private let confirmPhoneButton = CustomNarrowButton(isEnabled: false).then {
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitle("인증 번호", for: .normal)
    }

    private let notifyLabel = CustomLabel().then {
        $0.isHidden = true
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gzGreen
        $0.text = "인증번호가 발송됐습니다 (유효시간 1분)"
        $0.sizeToFit()
    }

    private let authenticTextField = CustomTextField().then {
        $0.placeholder = "인증 번호 입력"
        $0.setPlaceHolder()
    }

    private let confirmAuthenticButton = CustomNarrowButton(isEnabled: false).then {
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitle("인증 확인", for: .normal)
    }

    private let nextButton = CustomWideButton(isEnabled: false).then {
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.setTitle("다음", for: .normal)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        self.configureLayouts()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.configureCornerRadius()
    }
}

private extension AuthenticationViewController {

    func configureLayouts() {
        self.view.addSubviews(verticalStackView, confirmPhoneButton, authenticTextField, confirmAuthenticButton, nextButton)
        verticalStackView.addArrangedSubviews(phoneTextField, notifyLabel)
        self.configureStackSubviewsLayout()

        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(31)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
        }

        confirmPhoneButton.snp.makeConstraints { make in
            make.centerY.equalTo(phoneTextField.snp.centerY)
            make.trailing.equalTo(verticalStackView.snp.trailing).offset(-14)
            make.width.equalTo(83)
            make.height.equalTo(26)
        }

        authenticTextField.snp.makeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(20)
            make.leading.equalTo(verticalStackView.snp.leading)
            make.trailing.equalTo(verticalStackView.snp.trailing)
            make.height.equalTo(50)
        }

        confirmAuthenticButton.snp.makeConstraints { make in
            make.centerY.equalTo(authenticTextField.snp.centerY)
            make.trailing.equalTo(authenticTextField.snp.trailing).offset(-14)
            make.width.equalTo(83)
            make.height.equalTo(26)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.leading.equalTo(verticalStackView.snp.leading)
            make.trailing.equalTo(verticalStackView.snp.trailing)
            make.height.equalTo(50)
        }
    }

    func configureCornerRadius() {
        phoneTextField.setCornerRound(value: (phoneTextField.frame.height / 2))
        authenticTextField.setCornerRound(value: (authenticTextField.frame.height / 2))
        confirmPhoneButton.setCornerRound(value: (confirmPhoneButton.frame.height / 2))
        confirmAuthenticButton.setCornerRound(value: (confirmAuthenticButton.frame.height / 2))
        nextButton.setCornerRound(value: (nextButton.frame.height / 2))
    }
}

private extension AuthenticationViewController {

    func configureStackSubviewsLayout() {
        phoneTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
