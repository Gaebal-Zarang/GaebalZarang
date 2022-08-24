//
//  IntroduceViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/08.
//

import UIKit
import RxCocoa
import RxSwift

final class IntroduceViewController: UIViewController {

    let disposeBag = DisposeBag()

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "안녕하세요:) \n간단한 자기소개 부탁드려요", isRequire: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nickNameTextField: CustomTextField = {
        let textRound = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        let textField = CustomTextField()
        textField.setCornerRound(value: textRound)
        textField.placeholder = "별명설정"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var introTextView: UITextView = {
        let textRound = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.clipsToBounds = true
        textView.layer.cornerRadius = textRound
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        textView.textColor = UIColor.placeholderText
        textView.text = "간단한 자기소개"
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
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
        self.navigationController?.navigationBar.isHidden = true
        introTextView.delegate = self
        configureInnerActionBinding()
        configureLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustTextViewInset()
    }
}

private extension IntroduceViewController {

    func configureInnerActionBinding() {
        nextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(ProfileLocationViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}

private extension IntroduceViewController {

    func configureLayout() {

        self.view.addSubviews(inputTitleView, nickNameTextField, introTextView, nextButton)
        let defaultHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)

        // MARK: inputTitleView Constraints
        let inputTitleTopConstraint = DesignGuide.estimateYAxisLength(origin: 17, frame: view.frame)
        let inputTitleLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 35, frame: view.frame)

        NSLayoutConstraint.activate([
            inputTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inputTitleTopConstraint),
            inputTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inputTitleLeadingConstraint)
        ])

        // MARK: nickNameTextField Constraints
        let nickNameTopConstraint = DesignGuide.estimateYAxisLength(origin: 30, frame: view.frame)
        let nickNameleadingConstraint = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame)

        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: inputTitleView.bottomAnchor, constant: nickNameTopConstraint),
            nickNameTextField.heightAnchor.constraint(equalToConstant: defaultHeight),
            nickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: nickNameleadingConstraint),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -nickNameleadingConstraint)
        ])

        // MARK: introTextView Constraints
        let introTopConstraint = DesignGuide.estimateYAxisLength(origin: 14, frame: view.frame)

        NSLayoutConstraint.activate([
            introTextView.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: introTopConstraint),
            introTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: defaultHeight),
            introTextView.leadingAnchor.constraint(equalTo: nickNameTextField.leadingAnchor),
            introTextView.trailingAnchor.constraint(equalTo: nickNameTextField.trailingAnchor)

        ])

        // MARK: nextButton Constraints
        let nextBtnBottomConstraint = -(DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame))

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: nextBtnBottomConstraint),
            nextButton.heightAnchor.constraint(equalTo: nickNameTextField.heightAnchor),
            nextButton.leadingAnchor.constraint(equalTo: introTextView.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: introTextView.trailingAnchor),
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: introTextView.bottomAnchor, constant: 50)
        ])
    }

    func adjustTextViewInset() {
        let fontSize: CGFloat = 17
        let axisYPadding: CGFloat = (introTextView.frame.height - fontSize) / 2
        introTextView.textContainerInset = .init(top: axisYPadding, left: 20, bottom: axisYPadding, right: 25)
    }
}

// MARK: textField Delegate
extension IntroduceViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "간단한 자기소개"
            textView.textColor = .placeholderText
        }
    }

}
