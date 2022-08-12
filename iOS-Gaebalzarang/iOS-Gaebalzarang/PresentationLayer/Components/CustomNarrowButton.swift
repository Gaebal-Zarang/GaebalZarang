//
//  CustomNarrowButton.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/12.
//

import UIKit

final class CustomNarrowButton: UIButton {

    override var isEnabled: Bool {
        willSet(newVal) {
            newVal ? configureEnabledSetting() : configureDisabledSetting()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        isEnabled = false
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

private extension CustomNarrowButton {

    func configureEnabledSetting() {
        backgroundColor = .gzGreen
    }

    func configureDisabledSetting() {
        backgroundColor = .gzGray2
    }
}
