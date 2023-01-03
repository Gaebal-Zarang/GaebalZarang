//
//  ViewValidityCheckUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation

protocol CheckUsecase {

    func execute<T>(with text: T, classify: ValidationCheckCase) -> Bool
}
