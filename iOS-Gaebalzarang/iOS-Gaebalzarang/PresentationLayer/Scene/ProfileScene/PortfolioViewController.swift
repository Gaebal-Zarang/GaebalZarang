//
//  PortfolioViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/22.
//

import UIKit
import RxCocoa
import RxSwift

final class PortfolioViewController: UIViewController {

    let disposeBag = DisposeBag()

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "포트폴리오에 연결가능한\n링크를 작성해주세요", isRequire: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()

    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .gzGreen
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
        addLinkTextField()
        configureInnerActionBinding()
        configureLayout()
    }
}

private extension PortfolioViewController {

    func configureInnerActionBinding() {
        nextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(ScheduleViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }

    func addLinkTextField() {
        let textField = CustomTextField()
        let cornerRadius = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        textField.setCornerRound(value: cornerRadius)
        textField.placeholder = "링크 입력"
        stackView.addArrangedSubviews(textField)
    }

    func configureLayout() {
        self.view.addSubviews(inputTitleView, stackView, addButton, nextButton)

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

        let addButtonTopConstraint = DesignGuide.estimateYAxisLength(origin: 14, frame: view.frame)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: addButtonTopConstraint),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: defaultHeight),
            addButton.widthAnchor.constraint(equalToConstant: defaultHeight)
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
