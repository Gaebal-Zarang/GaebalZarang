//
//  LoginViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit

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

    private lazy var loginButton: UIButton = {
        let loginButtonRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(red: 0, green: 188 / 255, blue: 120 / 255, alpha: 1.0)
        button.clipsToBounds = true
        button.layer.cornerRadius = loginButtonRound
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
    }

}

private extension LoginViewController {

    func configureLayouts() {
        view.addSubviews(logoView, idTextField, pswTextField, loginButton)

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

        let loginBtnTopConstant = (179 / designExampleHeight) * view.frame.height

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: pswTextField.bottomAnchor, constant: loginBtnTopConstant),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: idTextWidth),
            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
}
