//
//  CustomSelectButton.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/22.
//

import UIKit

final class CustomSelectButton: UIButton {

    override var isSelected: Bool {
        willSet(newVal) {
            newVal ? configureSelectedSetting() : configureUnSelectedSetting()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .selected)
        self.setTitleColor(UIColor.gzGray1, for: .normal)
    }

    convenience init(isSelected: Bool) {
        self.init()
        self.isSelected = isSelected
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

private extension CustomSelectButton {

    func configureSelectedSetting() {
        backgroundColor = .gzGreen
        layer.borderWidth = 0

    }

    func configureUnSelectedSetting() {
        self.layer.borderColor = UIColor.gzGray1?.cgColor
        backgroundColor = .white
        layer.borderWidth = 1
    }
}
