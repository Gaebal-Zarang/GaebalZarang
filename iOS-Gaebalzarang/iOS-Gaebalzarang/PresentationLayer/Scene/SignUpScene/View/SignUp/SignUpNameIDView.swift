//
//  SignUpNameIDView.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpNameIDView: UIView {

    private var viewControllerFrame: CGRect = CGRect()

    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "이름"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var idTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "ID"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var overlapCheckButton: CustomNarrowButton = {
        let button = CustomNarrowButton(isEnabled: true)
        button.setTitle("중복 확인", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
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

    func setCheckingIDValid() -> Observable<String?> {
        return idTextField.rx.text.asObservable()
    }

    func setOverlapButtonAction() -> Driver<Void> {
        return overlapCheckButton.rx.tap.asDriver()
    }
}

extension SignUpNameIDView {

    func checkValid(with isValid: Bool) {
        idTextField.layer.borderColor = isValid ? UIColor.red.cgColor : UIColor.gzGreen?.cgColor
    }

    func checkOverrapped(with isOverrapped: Bool) {
        isOverrapped ? configureValidText() : configureInvalidText()
    }

    func resetVaildCheck() {
        validCheckLabel.text = ""
    }
}

private extension SignUpNameIDView {

    func configureLayouts() {
        addSubviews(nameTextField, idTextField, overlapCheckButton, validCheckLabel)

        let textFieldHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        let idFieldTopConstant = DesignGuide.estimateYAxisLength(origin: 14, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: idFieldTopConstant),
            idTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            idTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            idTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])

        let buttonWidth = DesignGuide.estimateXAxisLength(origin: 83, frame: viewControllerFrame)
        let buttonHeight = DesignGuide.estimateYAxisLength(origin: 26, frame: viewControllerFrame)
        let buttonTrailingConstant = DesignGuide.estimateXAxisLength(origin: 14, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            overlapCheckButton.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor, constant: -(buttonTrailingConstant)),
            overlapCheckButton.centerYAnchor.constraint(equalTo: idTextField.centerYAnchor),
            overlapCheckButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            overlapCheckButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        let labelHeight = DesignGuide.estimateYAxisLength(origin: 25, frame: viewControllerFrame)
        let labelTopConstant = DesignGuide.estimateYAxisLength(origin: 7, frame: viewControllerFrame)
        let labelLeadingConstant = DesignGuide.estimateXAxisLength(origin: 18, frame: viewControllerFrame)

        NSLayoutConstraint.activate([
            validCheckLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: labelTopConstant),
            validCheckLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: labelLeadingConstant),
            validCheckLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }

    func configureCornerRadius() {
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: viewControllerFrame)
        let btnRound = DesignGuide.estimateNarrowViewCornerRadius(frame: viewControllerFrame)

        nameTextField.setCornerRound(value: viewRound)
        idTextField.setCornerRound(value: viewRound)
        overlapCheckButton.setCornerRound(value: btnRound)
    }

    func configureValidText() {
        validCheckLabel.text = "사용 가능한 아이디입니다."
        validCheckLabel.textColor = .gzGreen
    }

    func configureInvalidText() {
        validCheckLabel.text = "이미 존재하는 아이디입니다."
        validCheckLabel.textColor = .red
    }
}
