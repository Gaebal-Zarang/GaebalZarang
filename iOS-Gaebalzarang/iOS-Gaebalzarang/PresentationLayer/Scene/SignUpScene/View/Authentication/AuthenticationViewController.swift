//
//  AuthenticationViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa

// TODO: 인증 번호, 확인 버튼 isEnable false로 바꾸고 값 입력시 true로 변경
final class AuthenticationViewController: UIViewController {

    let disposeBag = DisposeBag()

    private lazy var contentView = AuthenticationContentView(with: view.frame)

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
}

private extension AuthenticationViewController {

    func configureNavigationItem() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gzGreen
        label.sizeToFit()

        navigationItem.titleView = label
    }

    func configureLayouts() {
        view.addSubviews(contentView, nextButton)

        let contentViewTopConstant = DesignGuide.estimateYAxisLength(origin: 26, frame: view.frame)
        let viewWidth = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)
        let viewHeight = DesignGuide.estimateYAxisLength(origin: 152, frame: view.frame)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: contentViewTopConstant),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.widthAnchor.constraint(equalToConstant: viewWidth),
            contentView.heightAnchor.constraint(equalToConstant: viewHeight)
        ])

        let nextButtonHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)
        let buttonBottomConstant = DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame)

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(buttonBottomConstant)),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: viewWidth),
            nextButton.heightAnchor.constraint(equalToConstant: nextButtonHeight)
        ])
    }

    func configureInnerActionBinding() {
        contentView.setReceiveCodeButtonAction()
            .drive { [weak self] _ in
                self?.contentView.tappedReceiveCodeButton()
            }
            .disposed(by: disposeBag)

        contentView.setCheckCodeButtonAction()
            .drive { [weak self] _ in

            }
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let nextVC = CompleteViewController()
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
