//
//  SkillViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/22.
//

import UIKit

final class SkillViewController: UIViewController {

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "사용하는 언어나\n선호하는 협업 툴을\n작성해주세요.", isRequire: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var textField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: self.view.frame)
        textField.setCornerRound(value: viewRound)
        textField.placeholder = "입력"
        return textField
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
