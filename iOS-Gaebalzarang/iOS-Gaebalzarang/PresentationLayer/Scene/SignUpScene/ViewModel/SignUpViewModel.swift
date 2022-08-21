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

    struct SignUpInput {
        let idValidationCheckEvent: Driver<String?>
        let idUseableCheckEvent: Driver<Void>

        let pswValidationCheckEvent: Driver<String?>
        let pswEqualCheckEvent: Driver<String?>
    }

    struct SignUpOutput {
        let idValidationSubject = PublishRelay<ValidationCheckCase>()
        let pswValidationSubject = PublishRelay<ValidationCheckCase>()
    }

    struct AuthenticInput {
        let phoneNumberCheckEvent: Driver<String?>
    }

    struct AuthenticOutput {
        let phoneNumberSubject = PublishRelay<Bool>()
    }

    let idCheckUsecase: CheckValidityUsecase
    let pswCheckUsecase: CheckValidityUsecase
    let authenticUsecase: CheckValidityUsecase

    private var inputID = ""
    private var inputPSW = ""

    init(idUsecase: CheckValidityUsecase, pswUsecase: CheckValidityUsecase, autenticUsecase: CheckValidityUsecase) {
        self.idCheckUsecase = idUsecase
        self.pswCheckUsecase = pswUsecase
        self.authenticUsecase = autenticUsecase
    }

    convenience init() {
        self.init(idUsecase: CheckUserIdValidityUsecase(), pswUsecase: CheckUserPswValidityUsecase(), autenticUsecase: CheckAuthenticValidityUsecase())
    }

    func transform(input: SignUpInput, disposeBag: DisposeBag) -> SignUpOutput {
        let output = SignUpOutput()

        input.idValidationCheckEvent
            .drive { [weak self] text in
                guard let validText = text, let validation = self?.idCheckUsecase.executeValidation(with: validText) else { return }
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
                guard let validText = text, let validation = self?.pswCheckUsecase.executeValidation(with: validText) else { return }
                self?.inputPSW = validText
                output.pswValidationSubject.accept(validation)
            }
            .disposed(by: disposeBag)

        // MARK: TextField 포인터 살아있을 때, next 버튼으로 VC 이동하면 여기 액션이 한 번 더 호출되
        input.pswEqualCheckEvent
            .drive { [weak self] text in
                guard let validText = text, let validation = self?.pswCheckUsecase.executeConfirm(with: validText, compare: self?.inputPSW) else { return }
                output.pswValidationSubject.accept(validation)
            }
            .disposed(by: disposeBag)

        return output
    }

    func transform(input: AuthenticInput, disposeBag: DisposeBag) -> AuthenticOutput {
        let output = AuthenticOutput()

        input.phoneNumberCheckEvent
            .drive { [weak self] numberString in
                guard let numberString = numberString, let validation = self?.authenticUsecase.executeValidation(with: numberString) else { return }
                switch validation {
                case .valid:
                    output.phoneNumberSubject.accept(true)
                default:
                    output.phoneNumberSubject.accept(false)
                }
            }
            .disposed(by: disposeBag)

        return output
    }
}
