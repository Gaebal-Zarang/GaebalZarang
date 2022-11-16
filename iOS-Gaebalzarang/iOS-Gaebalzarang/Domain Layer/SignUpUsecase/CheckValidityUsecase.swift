//
//  ViewSignUpValidityCheckUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation

final class CheckValidityUsecase: CheckUsecase {
    
    func execute<T>(with text: T, classify: ValidationCheckCase) -> Bool {
        guard let text = text as? String else { return false }
        
        switch classify {
        case .name:
            return checkNameValidation(of: text)
            
        case .id:
            return checkIdValidation(of: text)
            
        case .psw:
            return checkPswValidation(of: text)
        }
    }
}

private extension CheckValidityUsecase {

    func checkNameValidation(of text: String) -> Bool {
        let regex = "^[가-힣]{2,3}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: text)
    }
    
    func checkIdValidation(of text: String) -> Bool {
        let regex = "^[A-Z0-9a-z]+@[a-z0-9]+\\.[a-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: text)
    }
    
    func checkPswValidation(of text: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%])(?=.*[0-9]).{8,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: text)
    }
}
