//
//  ViewValidityCheckUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation

protocol ViewValidityCheckUsecase {
    
    func execute(with text: String, about section: ValidationSectionCase) -> ValidationCheckCase?
}
