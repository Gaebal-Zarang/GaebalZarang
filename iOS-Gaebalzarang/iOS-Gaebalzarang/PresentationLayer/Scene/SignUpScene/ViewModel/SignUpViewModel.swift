//
//  SignUpViewModel.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class SignUpViewModel {

    struct Input {
        let idValidationCheckEvent: Driver<String?>
        let idUseableCheckEvent: Driver<Void>
    }

    struct Output {
        let validationSubject = PublishRelay<ValidationCheckCase>()
    }

    let idCheckUsecase: CheckValidityUsecase

    private var inputID = ""
    private var inputPSW = ""

    init(idUsecase: CheckValidityUsecase) {
        self.idCheckUsecase = idUsecase
    }

    convenience init() {
        self.init(idUsecase: CheckUserIdValidityUsecase())
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        input.idValidationCheckEvent
            .drive { [weak self] text in
                guard let validText = text, validText != "", let validation = self?.idCheckUsecase.executeValidation(with: validText) else { return }
                self?.inputID = validText
                output.validationSubject.accept(validation)
            }
            .disposed(by: disposeBag)

        input.idUseableCheckEvent
            .drive { [weak self] _ in
                // MARK: ID 중복 네트워크 서비스
                guard let self = self else { return }
                let useable = self.idCheckUsecase.executeConfirm(with: self.inputID)
                output.validationSubject.accept(useable)
            }
            .disposed(by: disposeBag)

        return output
    }
}
