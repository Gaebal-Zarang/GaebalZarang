//
//  IntroduceViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/08.
//

import UIKit

final class IntroduceViewController: UIViewController {

    let designExampleWidth: CGFloat = 375
    let designExampleHeight: CGFloat = 667

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요:)\n간단한 자기소개 부탁드려요."
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var optionLabel: UILabel = {
        let label = UILabel()
        label.text = "*필수"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nickNameTextField: CustomTextField = {
        let textField = CustomTextField()
        let textFieldRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        textField.setCornerRound(value: textFieldRound)
        textField.placeholder = "별명설정"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var introTextView: UITextView = {
        let textView = UITextView()
        let textViewRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.clipsToBounds = true
        textView.layer.cornerRadius = textViewRound
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        textView.textColor = UIColor.placeholderText
        textView.text = "간단한 자기소개"
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.sizeToFit()
        textView.textContainerInset = .init(top: 15, left: 20, bottom: 15, right: 25)
        textView.isScrollEnabled = false
        return textView
    }()

    private lazy var nextButton: CustomButton = {
        let button = CustomButton()
        let buttonRound = ((50 / designExampleHeight) * view.frame.height) / 2.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setCornerRound(value: buttonRound)
        button.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        button.setTitle("다음", for: .disabled)
        button.setTitleColor(UIColor.placeholderText, for: .disabled)
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        introTextView.delegate = self
        addsubViews()
        configureLayout()
    }
}

private extension IntroduceViewController {
    func addsubViews() {
        view.addSubview(titleLabel)
        view.addSubview(optionLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(introTextView)
        view.addSubview(nextButton)
    }

    func configureLayout() {

        let titleTopConstraint = DesignGuide.estimateYAxisLength(origin: 17, frame: view.frame)
        let titleWidthConstraint = DesignGuide.estimateXAxisLength(origin: 267, frame: view.frame)

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: titleTopConstraint),
            titleLabel.widthAnchor.constraint(equalToConstant: titleWidthConstraint),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 64)
        ])

        let optionTopConstraint = DesignGuide.estimateYAxisLength(origin: 5, frame: view.frame)

        NSLayoutConstraint.activate([
            optionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: optionTopConstraint),
            optionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])

        let nickNameTopConstraint = DesignGuide.estimateYAxisLength(origin: 30, frame: view.frame)
        let nickNameWidthConstraint = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)

        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: nickNameTopConstraint),
            nickNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nickNameTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            nickNameTextField.widthAnchor.constraint(equalToConstant: nickNameWidthConstraint)
        ])

        let introTopConstraint = DesignGuide.estimateYAxisLength(origin: 14, frame: view.frame)

        NSLayoutConstraint.activate([
            introTextView.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: introTopConstraint),
            introTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introTextView.widthAnchor.constraint(equalTo: nickNameTextField.widthAnchor)

        ])

        let nextBtnBottomConstraint = -(DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame))

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: nextBtnBottomConstraint),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: introTextView.widthAnchor),
            nextButton.heightAnchor.constraint(equalTo: nickNameTextField.heightAnchor),

            nextButton.topAnchor.constraint(greaterThanOrEqualTo: introTextView.bottomAnchor, constant: 50)
        ])

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
