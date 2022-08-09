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

    private var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.addLeftPadding()
        textField.placeholder = "별명설정"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 30
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        textField.sizeToFit()
        return textField
    }()

    private var introTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 30
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

    private var nextButton: CustomNextButton = {
        let button = CustomNextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setCornerRound(value: 30)
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

        let titleTopConstraint = (17 / designExampleHeight) * view.frame.height
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: titleTopConstraint),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 64)
        ])

        NSLayoutConstraint.activate([
            optionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            optionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 30),
            nickNameTextField.leadingAnchor.constraint(equalTo: optionLabel.leadingAnchor),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 50),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])

        NSLayoutConstraint.activate([
            introTextView.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 30),
            introTextView.leadingAnchor.constraint(equalTo: optionLabel.leadingAnchor),
            introTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: introTextView.bottomAnchor, constant: 100)
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
