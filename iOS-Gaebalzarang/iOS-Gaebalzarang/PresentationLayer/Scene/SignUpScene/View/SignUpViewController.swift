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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        configureInnerActionBinding()
    }
}

private extension SignUpViewController {

    func configureLayouts() {
        view.addSubviews(nameIDView, passwordView)

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
    }

    func configureInnerActionBinding() {
        nameIDView.setOverlapButtonAction()
            .bind { [weak self] _ in
                self?.nameIDView.validCheck(with: true)
            }
            .disposed(by: disposeBag)
    }
}
