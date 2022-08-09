//
//  CustomButton.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit

final class CustomButton: UIButton {

    override var isEnabled: Bool {
        willSet(newVal) {
            newVal ? configureEnabledSetting() : configureDisabledSetting()
        }
    }

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
}

private extension CustomButton {

    func configureBasicSetting() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        layer.borderColor = UIColor.gzGreen?.cgColor
    }

    func configureEnabledSetting() {
        backgroundColor = .gzGreen
        layer.borderWidth = 0
        setTitleColor(.white, for: .normal)
    }

    func configureDisabledSetting() {
        backgroundColor = .white
        layer.borderWidth = 1
        setTitleColor(.gzGreen, for: .normal)
    }
}
