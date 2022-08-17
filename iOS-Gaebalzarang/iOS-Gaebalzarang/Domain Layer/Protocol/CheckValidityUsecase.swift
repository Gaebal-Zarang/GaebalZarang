//
//  ViewValidityCheckUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation

protocol CheckValidityUsecase {

    func executeValidation(with text: String) -> ValidationCheckCase
    func executeConfirm(with text: String, compare: String?) -> ValidationCheckCase
}
