//
//  SignUpViewModel.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation
import RxSwift

final class SignUpViewModel {

    struct Input {
        let validationCheckEvent: Observable<String>
    }

    struct Output {

    }
    
    let idCheckUsecase: CheckValidityUsecase

    init(idUsecase: CheckValidityUsecase) {
        self.idCheckUsecase = idUsecase
    }

    convenience init() {
        self.init(idUsecase: CheckUserIdValidityUsecase())
    }

    func enquireValidationCheck(with text: String, about section: ValidationSectionCase) {

    }
}
