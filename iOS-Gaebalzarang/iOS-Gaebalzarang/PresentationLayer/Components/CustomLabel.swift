//
//  CustomLabel.swift
//  iOS-Gaebalzarang
//
//  Created by Zeto on 2022/11/16.
//

import UIKit

class CustomLabel: UILabel {

    private var padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
