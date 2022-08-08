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

    private lazy var idTextField: UITextField = {
        let textFieldRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        let textField = UITextField()
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.5
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.textColor = .gray
        textField.addLeftPadding()
        textField.placeholder = "ID"
        textField.clipsToBounds = true
        textField.layer.cornerRadius = textFieldRound
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
    }

}

private extension LoginViewController {

    func configureLayouts() {
        view.addSubviews(logoView, idTextField)

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
    }
}
