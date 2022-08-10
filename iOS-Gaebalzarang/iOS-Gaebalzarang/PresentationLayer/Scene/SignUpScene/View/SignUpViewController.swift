//
//  SignUpViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {

    let disposeBag = DisposeBag()

    private lazy var nameIDView = SignUpNameIDView(with: view.frame)
    private lazy var passwordView = SignUpPasswordView(with: view.frame)

    private lazy var nextButton: CustomButton = {
        let nextButtonRound = DesignGuide.estimateCornerRadius(origin: 50, frame: view.frame)
        let button = CustomButton()
        button.setTitle("다음", for: .normal)
        button.setCornerRound(value: nextButtonRound)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        configureInnerActionBinding()
    }
}

private extension SignUpViewController {

    func configureLayouts() {
        view.addSubviews(nameIDView, passwordView, nextButton)

        let viewWidth = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)
        let viewHeight = DesignGuide.estimateYAxisLength(origin: 146, frame: view.frame)
        let nameIDTopConstant = DesignGuide.estimateYAxisLength(origin: 21, frame: view.frame)

        NSLayoutConstraint.activate([
            nameIDView.widthAnchor.constraint(equalToConstant: viewWidth),
            nameIDView.heightAnchor.constraint(equalToConstant: viewHeight),
            nameIDView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: nameIDTopConstant),
            nameIDView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        let passwordTopConstant = DesignGuide.estimateYAxisLength(origin: 20, frame: view.frame)

        NSLayoutConstraint.activate([
            passwordView.widthAnchor.constraint(equalToConstant: viewWidth),
            passwordView.heightAnchor.constraint(equalToConstant: viewHeight),
            passwordView.topAnchor.constraint(equalTo: nameIDView.bottomAnchor, constant: passwordTopConstant),
            passwordView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        let buttonHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)
        let buttonTopConstant = DesignGuide.estimateYAxisLength(origin: 179, frame: view.frame)

        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: buttonTopConstant),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: viewWidth),
            nextButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }

    func configureInnerActionBinding() {
        nameIDView.setOverlapButtonAction()
            .bind { [weak self] _ in
                self?.nameIDView.validCheck(with: true)
            }
            .disposed(by: disposeBag)

    }
}
