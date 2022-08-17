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

        let pswValidationCheckEvent: Driver<String?>
        let pswEqualCheckEvent: Driver<String?>
    }

    struct Output {
        let idValidationSubject = PublishRelay<ValidationCheckCase>()
        let pswValidationSubject = PublishRelay<ValidationCheckCase>()
    }

    let idCheckUsecase: CheckValidityUsecase
    let pswCheckUsecase: CheckValidityUsecase

    private var inputID = ""
    private var inputPSW = ""

    init(idUsecase: CheckValidityUsecase, pswUsecase: CheckValidityUsecase) {
        self.idCheckUsecase = idUsecase
        self.pswCheckUsecase = pswUsecase
    }

    convenience init() {
        self.init(idUsecase: CheckUserIdValidityUsecase(), pswUsecase: CheckUserPswValidityUsecase())
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        input.idValidationCheckEvent
            .drive { [weak self] text in
                guard let validText = text, validText != "", let validation = self?.idCheckUsecase.executeValidation(with: validText) else { return }
                self?.inputID = validText
                output.idValidationSubject.accept(validation)
            }
            .disposed(by: disposeBag)

        input.idUseableCheckEvent
            .drive { [weak self] _ in
                // MARK: ID 중복 네트워크 서비스
                guard let self = self else { return }
                let useable = self.idCheckUsecase.executeConfirm(with: self.inputID, compare: nil)
                output.idValidationSubject.accept(useable)
            }
            .disposed(by: disposeBag)

        input.pswValidationCheckEvent
            .drive { [weak self] text in
                guard let validText = text, validText != "", let validation = self?.pswCheckUsecase.executeValidation(with: validText) else { return }
                self?.inputPSW = validText
                output.pswValidationSubject.accept(validation)
            }
            .disposed(by: disposeBag)

        input.pswEqualCheckEvent
            .drive { [weak self] text in
                guard let validText = text, validText != "", let validation = self?.pswCheckUsecase.executeConfirm(with: validText, compare: self?.inputPSW) else { return }
                output.pswValidationSubject.accept(validation)
            }
            .disposed(by: disposeBag)

        return output
    }
}
