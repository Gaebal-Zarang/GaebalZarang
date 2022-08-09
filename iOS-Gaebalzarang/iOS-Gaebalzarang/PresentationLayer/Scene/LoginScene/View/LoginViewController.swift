//
//  LoginViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    let designExampleWidth: CGFloat = 375
    let designExampleHeight: CGFloat = 667

    private lazy var logoView: UIImageView = {
        let imageViewRound = ((140 / designExampleWidth) * view.frame.width) / 2
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageViewRound
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var idTextField: CustomTextField = {
        let textFieldRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        let textField = CustomTextField()
        textField.setCornerRound(value: textFieldRound)
        textField.placeholder = "ID"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var pswTextField: CustomTextField = {
        let pswFieldRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        let pswField = CustomTextField()
        pswField.setCornerRound(value: pswFieldRound)
        pswField.placeholder = "PW"
        pswField.translatesAutoresizingMaskIntoConstraints = false

        return pswField
    }()

    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.gzGreen, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var loginButton: CustomButton = {
        let loginButtonRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        let button = CustomButton()
        button.setTitle("로그인", for: .normal)
        button.setCornerRound(value: loginButtonRound)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var searchSignView: LoginSearchSignView = {
        let view = LoginSearchSignView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
    }

}

private extension LoginViewController {

    func configureLayouts() {
        view.addSubviews(logoView, idTextField, pswTextField, showButton, searchSignView, loginButton)

        let logoViewWidth = (140 / designExampleWidth) * view.frame.width
        let logoViewTopConstant = (45 / designExampleHeight) * view.frame.height

        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: logoViewWidth),
            logoView.heightAnchor.constraint(equalToConstant: logoViewWidth),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logoViewTopConstant)
        ])

        let idTextTopConstant = (68 / designExampleHeight) * view.frame.height
        let idTextWidth = (322 / designExampleWidth) * view.frame.width

        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: idTextTopConstant),
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idTextField.widthAnchor.constraint(equalToConstant: idTextWidth),
            idTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])

        let pswTextTopConstant = (12 / designExampleHeight) * view.frame.height

        NSLayoutConstraint.activate([
            pswTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: pswTextTopConstant),
            pswTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pswTextField.widthAnchor.constraint(equalToConstant: idTextWidth),
            pswTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])

        let showBtnWidth = (40 / designExampleWidth) * view.frame.width
        let showBtnHeight = (25 / designExampleHeight) * view.frame.height
        let showBtnTrailingConstant = -((56 / designExampleWidth) * view.frame.width)

        NSLayoutConstraint.activate([
            showButton.centerYAnchor.constraint(equalTo: pswTextField.centerYAnchor),
            showButton.widthAnchor.constraint(equalToConstant: showBtnWidth),
            showButton.heightAnchor.constraint(equalToConstant: showBtnHeight),
            showButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: showBtnTrailingConstant)
        ])

        let searchSignWidth = (235 / designExampleWidth) * view.frame.width
        let searchSignHeight = (19 / designExampleHeight) * view.frame.height

        NSLayoutConstraint.activate([
            searchSignView.topAnchor.constraint(equalTo: pswTextField.bottomAnchor, constant: pswTextTopConstant),
            searchSignView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchSignView.widthAnchor.constraint(equalToConstant: searchSignWidth),
            searchSignView.heightAnchor.constraint(equalToConstant: searchSignHeight)
        ])

        let loginBtnTopConstant = (148 / designExampleHeight) * view.frame.height

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: searchSignView.bottomAnchor, constant: loginBtnTopConstant),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: idTextWidth),
            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
}
