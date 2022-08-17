//
//  CheckUserPswValidityUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation

final class CheckUserPswValidityUsecase: CheckValidityUsecase {

    func executeValidation(with text: String) -> ValidationCheckCase {
        return checkValidation(of: text)
    }

    func executeConfirm(with text: String, compare: String?) -> ValidationCheckCase {
        guard let compare = compare else { return .onError }

        return text == compare ? .pswEqual : .pswNonEqual
    }
}

private extension CheckUserPswValidityUsecase {

    func checkValidation(of text: String) -> ValidationCheckCase {
        let pattern: String = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%])(?=.*[0-9]).{8,16}$"
        let regex = try? NSRegularExpression(pattern: pattern)

        guard let _ = regex?.firstMatch(in: text, range: NSRange(location: 0, length: text.count)) else {
            return .inValid
        }

        return .valid
    }
}
