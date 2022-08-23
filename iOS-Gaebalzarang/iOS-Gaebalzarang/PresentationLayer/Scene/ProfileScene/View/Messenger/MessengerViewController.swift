//
//  MessengerViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/23.
//

import UIKit
import RxSwift
import RxCocoa

final class MessengerViewController: UIViewController {

    let disposeBag = DisposeBag()

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "마지막으로,\n1:1 메신저 허용 여부에 대해\n선택해주세요 :)", isRequire: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var yesButton: CustomSelectButton = {
        let button = CustomSelectButton(isSelected: false)
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: self.view.frame)
        button.isEnabled = true
        button.setCornerRound(value: viewRound)
        button.setTitle("예", for: .normal)
        return button
    }()

    private lazy var noButton: CustomSelectButton = {
        let button = CustomSelectButton(isSelected: false)
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: self.view.frame)
        button.setCornerRound(value: viewRound)
        button.isEnabled = true
        button.setTitle("아니오", for: .normal)
        return button
    }()

    private lazy var nextButton: CustomWideButton = {
        let btnRound = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        let button = CustomWideButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setCornerRound(value: btnRound)
        button.setTitle("다음", for: .normal)
        // TODO: false로 변경해주어야 함
        button.isEnabled = true

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureLayout()
        configureInnerActionBinding()
    }
}

private extension MessengerViewController {

    func configureInnerActionBinding() {
        yesButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.yesButton.isSelected = true
                self?.noButton.isSelected = false
            }
            .disposed(by: disposeBag)

        noButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.noButton.isSelected = true
                self?.yesButton.isSelected = false
            }
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(ProfileCompleteViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: Layout
private extension MessengerViewController {

    func configureLayout() {
        stackView.addArrangedSubviews(yesButton, noButton)
        self.view.addSubviews(inputTitleView, stackView, nextButton)

        let defaultHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)

        // MARK: inputTitleView Constraints
        let inputTitleTopConstraint = DesignGuide.estimateYAxisLength(origin: 17, frame: view.frame)
        let inputTitleLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 35, frame: view.frame)

        NSLayoutConstraint.activate([
            inputTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inputTitleTopConstraint),
            inputTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inputTitleLeadingConstraint)
        ])

        let stackViewTopConstraint = DesignGuide.estimateYAxisLength(origin: 30, frame: view.frame)
        let stackViewLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: inputTitleView.bottomAnchor, constant: stackViewTopConstraint),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewLeadingConstraint),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -stackViewLeadingConstraint),
            stackView.heightAnchor.constraint(equalToConstant: defaultHeight)
        ])

        let nextBtnBottomConstraint = -(DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame))

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: nextBtnBottomConstraint),
            nextButton.heightAnchor.constraint(equalToConstant: defaultHeight),
            nextButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])

    }
}
