//
//  ViewSignUpValidityCheckUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation

final class CheckUserIdValidityUsecase: CheckValidityUsecase {

    func executeValidation(with text: String) -> ValidationCheckCase {
        return checkValidation(of: text)
    }

    func executeConfirm(with text: String) -> ValidationCheckCase {
        return checkOverrapped(of: text)
    }
}

private extension CheckUserIdValidityUsecase {

    func checkValidation(of text: String) -> ValidationCheckCase {
        let pattern: String = "^[0-9a-z_-]{5,20}$"
        let regex = try? NSRegularExpression(pattern: pattern)

        guard let _ = regex?.firstMatch(in: text, range: NSRange(location: 0, length: text.count)) else {
            return .inValid
        }

        return .valid
    }

    func checkOverrapped(of text: String) -> ValidationCheckCase {
        // MARK: API 구현 시, 중복 ID 호출
        return .idUseable
    }
}
