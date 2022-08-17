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

    private lazy var nextButton: CustomWideButton = {
        let btnRound = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        let button = CustomWideButton(isEnabled: true)
        button.setTitle("다음", for: .normal)
        button.setCornerRound(value: btnRound)
        // TODO: 유효성 검사 구현 시, isEnabled false로 변경
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationItem()
        configureLayouts()
        configureInnerActionBinding()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nameIDView.resetVaildCheck()
        passwordView.resetVaildCheck()
    }
}

private extension SignUpViewController {

    func configureNavigationItem() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gzGreen
        label.sizeToFit()

        navigationItem.titleView = label
        navigationItem.backButtonTitle = ""
    }

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
        let buttonBottomConstant = DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame)

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(buttonBottomConstant)),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: viewWidth),
            nextButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }

    func configureInnerActionBinding() {
        nameIDView.setOverlapButtonAction()
            .drive { [weak self] _ in
                self?.nameIDView.checkValid(with: true)
            }
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let nextVC = AuthenticationViewController()
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
