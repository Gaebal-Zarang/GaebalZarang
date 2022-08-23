//
//  LoginViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit
import RxSwift
import RxCocoa

// TODO: 텍스트 필드를 가진 모든 VC에서 키보드 올라오면 뷰도 같이 올라가고, 바깥을 터치하면 키보드 해제되는 기능 구현 필요
class LoginViewController: UIViewController {

    let disposeBag = DisposeBag()

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        let logoImage = UIImage(named: "logo")
        imageView.image = logoImage
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var idTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "ID"
        textField.setPlaceHolder()
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var pswTextField: CustomTextField = {
        let pswField = CustomTextField()
        pswField.addRightPadding(with: 75)
        pswField.placeholder = "PW"
        pswField.setPlaceHolder()
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

    private lazy var loginButton: CustomWideButton = {
        let button = CustomWideButton(isEnabled: true)
        button.setTitle("로그인", for: .normal)
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
        configureCornerRound()
        configureInnerActionBinding()
    }
}

private extension LoginViewController {

    func configureLayouts() {

        view.addSubviews(logoView, idTextField, pswTextField, showButton, searchSignView, loginButton)

        let defaultHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)

        let logoViewTopConstant = DesignGuide.estimateYAxisLength(origin: 45, frame: view.frame)

        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logoViewTopConstant)
        ])

        let idTextTopConstant = DesignGuide.estimateYAxisLength(origin: 68, frame: view.frame)
        let idTextWidth = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)

        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: idTextTopConstant),
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idTextField.widthAnchor.constraint(equalToConstant: idTextWidth),
            idTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: defaultHeight)
        ])

        let pswTextTopConstant = DesignGuide.estimateYAxisLength(origin: 12, frame: view.frame)

        NSLayoutConstraint.activate([
            pswTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: pswTextTopConstant),
            pswTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pswTextField.widthAnchor.constraint(equalToConstant: idTextWidth),
            pswTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: defaultHeight)
        ])

        let showBtnWidth = DesignGuide.estimateXAxisLength(origin: 40, frame: view.frame)
        let showBtnHeight = DesignGuide.estimateYAxisLength(origin: 25, frame: view.frame)
        let showBtnTrailingConstant = -(DesignGuide.estimateXAxisLength(origin: 56, frame: view.frame))

        NSLayoutConstraint.activate([
            showButton.centerYAnchor.constraint(equalTo: pswTextField.centerYAnchor),
            showButton.widthAnchor.constraint(equalToConstant: showBtnWidth),
            showButton.heightAnchor.constraint(equalToConstant: showBtnHeight),
            showButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: showBtnTrailingConstant)
        ])

        let searchSignWidth = DesignGuide.estimateXAxisLength(origin: 235, frame: view.frame)
        let searchSignHeight = DesignGuide.estimateYAxisLength(origin: 19, frame: view.frame)

        NSLayoutConstraint.activate([
            searchSignView.topAnchor.constraint(equalTo: pswTextField.bottomAnchor, constant: pswTextTopConstant),
            searchSignView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchSignView.widthAnchor.constraint(equalToConstant: searchSignWidth),
            searchSignView.heightAnchor.constraint(equalToConstant: searchSignHeight)
        ])

        let buttonBottomConstant = DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame)

        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(buttonBottomConstant)),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: idTextWidth),
            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: defaultHeight)
        ])
    }

    func configureCornerRound() {
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)

        idTextField.setCornerRound(value: viewRound)
        pswTextField.setCornerRound(value: viewRound)
        loginButton.setCornerRound(value: viewRound)
    }

    func configureInnerActionBinding() {
        searchSignView.setSignUpAction()
            .drive { [weak self] _ in
                let nextVC = SignUpViewController()
                let naviVC = UINavigationController(rootViewController: nextVC)
                naviVC.modalPresentationStyle = .overFullScreen
                self?.present(naviVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
