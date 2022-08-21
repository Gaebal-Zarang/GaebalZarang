//
//  CheckAuthenticValidityUsecase.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/21.
//

import Foundation

final class CheckAuthenticValidityUsecase: CheckValidityUsecase {

    func executeValidation(with text: String) -> ValidationCheckCase {
        return checkPhoneNumberValidation(of: text)
    }

    func executeConfirm(with text: String, compare: String?) -> ValidationCheckCase {
        // TODO: 인증번호 체크 API와 연동 구문 구현 예정

        return .onError
    }
}

private extension CheckAuthenticValidityUsecase {

    func checkPhoneNumberValidation(of text: String) -> ValidationCheckCase {
        let pattern: String = "^01[0][0-9]{8}$"
        let regex = try? NSRegularExpression(pattern: pattern)

        guard let _ = regex?.firstMatch(in: text, range: NSRange(location: 0, length: text.count)) else {
            return .inValid
        }

        return .valid
    }
}
