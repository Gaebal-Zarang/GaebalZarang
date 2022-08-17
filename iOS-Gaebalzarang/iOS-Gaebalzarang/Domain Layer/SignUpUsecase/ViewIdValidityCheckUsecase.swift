//
//  ViewSignUpValidityCheckUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation

final class ViewIdValidityCheckUsecase: ViewValidityCheckUsecase {
    
    func execute(with text: String, about section: ValidationSectionCase) -> ValidationCheckCase? {
        switch section {
        case .idValidityCheck:
            return checkValidation(of: text)
            
        case .idOverrapValidation:
            return nil
            
        default:
            return nil
        }
    }
}

private extension ViewIdValidityCheckUsecase {
    
    func checkValidation(of text: String) -> ValidationCheckCase {
        let pattern: String = "^[0-9a-z_-]{5,20}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        guard let _ = regex?.firstMatch(in: text, range: NSRange(location: 0, length: text.count)) else{
            return .inValid
        }
        
        return .valid
    }
}
