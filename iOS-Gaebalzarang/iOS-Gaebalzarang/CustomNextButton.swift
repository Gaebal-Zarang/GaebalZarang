//
//  CustomNextButton.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/08.
//

import UIKit

final class CustomNextButton: UIButton {
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

private extension CustomNextButton {

    func configureBasicSetting() {
            titleLabel?.textAlignment = .center
            titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            setTitleColor(.white, for: .normal)
        }
}
