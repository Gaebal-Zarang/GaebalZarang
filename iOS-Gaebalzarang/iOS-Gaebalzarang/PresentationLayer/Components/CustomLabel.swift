//
//  CustomLabel.swift
//  iOS-Gaebalzarang
//
//  Created by Zeto on 2022/11/16.
//

import UIKit

// MARK: For use label which can apply left padding
class CustomLabel: UILabel {

    private var padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)

    // 기본 값은 좌측 25 패딩이나, 생성 시 커스텀 패딩 값을 줘서 구현 가능
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    // label의 text 값이 그려질 때, rect에 관한 값을 수정 (rect에 inset을 먹일 수 있음)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    // padding만 추가할 경우 전체 크기는 그대로라 text가 잘릴 수 있으므로, 전체 크기를 변경해줄 필요 있음
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
