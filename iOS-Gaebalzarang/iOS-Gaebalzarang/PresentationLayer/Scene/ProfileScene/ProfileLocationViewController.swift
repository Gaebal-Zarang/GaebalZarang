//
//  ProfileLocationViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/10.
//

import UIKit

class ProfileLocationViewController: UIViewController {

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "주로 활동하시는\n지역은 어디신가요?", isRequire: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var locationTextField: CustomTextField = {
        let textField = CustomTextField()
        let cornerRadius = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        textField.setCornerRound(value: cornerRadius)
        textField.placeholder = "지역검색"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addRightImage(image: UIImage(systemName: "magnifyingglass") ?? UIImage())
        textField.rightViewMode = .always
        return textField
    }()

    private lazy var nextButton: CustomButton = {
        let button = CustomButton()
        let cornerRadius = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        button.setCornerRound(value: cornerRadius)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(touchedNextButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureLayout()
    }
}

private extension ProfileLocationViewController {

    func configureLayout() {
        view.addSubviews(inputTitleView, locationTextField, nextButton)

        let defaultHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)

        // MARK: inputTitleView Constraints
        let inputTitleTopConstraint = DesignGuide.estimateYAxisLength(origin: 17, frame: view.frame)
        let inputTitleLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 35, frame: view.frame)

        NSLayoutConstraint.activate([
            inputTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inputTitleTopConstraint),
            inputTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inputTitleLeadingConstraint)
        ])

        // MARK: locationTextField Constraints
        let locationTopConstraint = DesignGuide.estimateYAxisLength(origin: 30, frame: view.frame)
        let locationLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame)

        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: inputTitleView.bottomAnchor, constant: locationTopConstraint),
            locationTextField.heightAnchor.constraint(equalToConstant: defaultHeight),
            locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: locationLeadingConstraint),
            locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -locationLeadingConstraint)
        ])

        // MARK: nextButton Constraints
        let nextBtnBottomConstraint = -(DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame))

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: nextBtnBottomConstraint),
            nextButton.heightAnchor.constraint(equalTo: locationTextField.heightAnchor),
            nextButton.leadingAnchor.constraint(equalTo: locationTextField.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: locationTextField.trailingAnchor)
        ])
    }

    @objc
    func touchedNextButton() {
        self.navigationController?.pushViewController(ProfilePositionViewController(), animated: true)
    }
}
