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
        let nameValidationCheckEvent: Driver<String?>
        let idValidationCheckEvent: Driver<String?>
        let idUseableCheckEvent: Driver<Void>

        let pswValidationCheckEvent: Driver<String?>
        let pswEqualCheckEvent: Driver<String?>
    }

    struct SignUpOutput {
        let nameValidationSubject = PublishRelay<ValidationCheckCase>()
        let idValidationSubject = PublishRelay<ValidationCheckCase>()
        let pswValidationSubject = PublishRelay<ValidationCheckCase>()
    }

    struct AuthenticInput {
        let phoneNumberCheckEvent: Driver<String?>
        let authenticCodeCheckEvent: Driver<String?>
    }

    struct AuthenticOutput {
        let phoneNumberSubject = PublishRelay<Bool>()
        let authenticCodeValidationSubject = PublishRelay<Bool>()
    }

    let idCheckUsecase: CheckValidityUsecase
    let pswCheckUsecase: CheckValidityUsecase
    let authenticUsecase: CheckValidityUsecase

    private var inputID = ""
    private var inputPSW = ""
    private var authenticCode = ""

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

        input.nameValidationCheckEvent
            .drive { text in
                guard let name = text, name.count > 1, name.count < 11 else {
                    output.nameValidationSubject.accept(.inValid)
                    return
                }
                output.nameValidationSubject.accept(.valid)
            }
            .disposed(by: disposeBag)

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

        // TODO: 인증번호 요청 API 호출 및 요청받은 번호 저장 관련 input 생성 및 Repository 구현 필요 (데이터 authenticCode 프로퍼티에 저장)
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

        input.authenticCodeCheckEvent
            .drive { [weak self] codeString in
                guard let codeString = codeString, let validation = self?.authenticUsecase.executeConfirm(with: codeString, compare: self?.authenticCode) else { return }
                switch validation {
                case .valid:
                    output.authenticCodeValidationSubject.accept(true)
                default:
                    output.authenticCodeValidationSubject.accept(false)
                }
            }
            .disposed(by: disposeBag)

        return output
    }
}
