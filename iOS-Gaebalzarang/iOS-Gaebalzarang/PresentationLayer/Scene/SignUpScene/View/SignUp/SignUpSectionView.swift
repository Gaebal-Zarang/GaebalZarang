//
//  SignUpNameIDView.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpSectionView: UIView {

    private var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }

    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "이름은 2글자에서 3글자 한글"
        textField.setPlaceHolder()
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var idTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "5~20자의 영문 소문자, 숫자와 특수기호(_,-)"
        textField.setPlaceHolder()
        textField.addRightPadding(with: 123)
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

    init() {
        super.init(frame: .init())
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
