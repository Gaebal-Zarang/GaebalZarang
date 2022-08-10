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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayouts()
        configureInnerActionBinding()
    }
}

private extension SignUpViewController {

    func configureLayouts() {
        view.addSubviews(nameIDView)

        let nameIDWidth = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)
        let nameIDHeight = DesignGuide.estimateYAxisLength(origin: 146, frame: view.frame)
        let nameIDTopConstant = DesignGuide.estimateYAxisLength(origin: 21, frame: view.frame)

        NSLayoutConstraint.activate([
            nameIDView.widthAnchor.constraint(equalToConstant: nameIDWidth),
            nameIDView.heightAnchor.constraint(equalToConstant: nameIDHeight),
            nameIDView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: nameIDTopConstant),
            nameIDView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
