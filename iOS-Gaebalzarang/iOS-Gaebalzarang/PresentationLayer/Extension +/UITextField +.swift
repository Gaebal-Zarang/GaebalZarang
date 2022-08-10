//
//  UITextField +.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit

extension UITextField {

    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }

    func addRightImage(image: UIImage) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: image.size.height))
        let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        rightImage.tintColor = UIColor.gzGray4
        rightImage.image = image

        let stackView = UIStackView()

        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.addArrangedSubviews(rightImage, paddingView)

        self.rightView = stackView
    }
}
