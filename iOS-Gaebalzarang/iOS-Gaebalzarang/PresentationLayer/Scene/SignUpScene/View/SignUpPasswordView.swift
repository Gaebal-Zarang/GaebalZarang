//
//  SignUPPasswordView.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit

final class SignUpPasswordView: UIView {

    private var viewControllerFrame: CGRect = CGRect()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }

    convenience init(with viewControllerFrame: CGRect) {
        self.init()
        self.viewControllerFrame = viewControllerFrame
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
