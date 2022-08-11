//
//  DesignGuide.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/09.
//

import UIKit

struct DesignGuide {

    static let sampleDeviceWidth: CGFloat = 375
    static let sampleDeviceHeight: CGFloat = 623

    static func estimateXAxisLength(origin: CGFloat, frame: CGRect) -> CGFloat {
        return (origin / sampleDeviceWidth) * frame.width
    }

    static func estimateYAxisLength(origin: CGFloat, frame: CGRect) -> CGFloat {
        return (origin / sampleDeviceHeight) * frame.height
    }

    static func estimateCornerRadius(origin: CGFloat, frame: CGRect) -> CGFloat {
        return ((origin / sampleDeviceHeight) * frame.height) / 2.5
    }
}
