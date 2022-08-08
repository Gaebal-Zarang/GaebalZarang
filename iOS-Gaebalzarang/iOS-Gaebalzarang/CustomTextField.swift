//
//  CustomTextField.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit

final class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureBasicSetting()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCornerRound(value: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = value
    }

    func setPlaceHolder(text: String) {
        placeholder = text
    }
}

private extension CustomTextField {

    func configureBasicSetting() {
        layer.borderColor = UIColor(red: 237 / 255, green: 237 / 255, blue: 237 / 255, alpha: 1.0).cgColor
        layer.borderWidth = 1.0
        font = .systemFont(ofSize: 16, weight: .regular)
        textColor = UIColor(red: 172 / 255, green: 172 / 255, blue: 172 / 255, alpha: 1.0)
        addLeftPadding()
    }
}
