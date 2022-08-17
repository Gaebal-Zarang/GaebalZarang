//
//  CustomButton.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit

final class CustomWideButton: UIButton {

    override var isEnabled: Bool {
        willSet(newVal) {
            newVal ? configureEnabledSetting() : configureDisabledSetting()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }

    convenience init(isEnabled: Bool) {
        self.init()
        self.isEnabled = isEnabled
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

private extension CustomWideButton {

    func configureEnabledSetting() {
        backgroundColor = .gzGreen
        layer.borderWidth = 0
        setTitleColor(.white, for: .normal)
    }

    func configureDisabledSetting() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gzGreen?.cgColor
        setTitleColor(.gzGreen, for: .normal)
    }
}
