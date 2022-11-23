//
//  AuthenticationViewModel.swift
//  iOS-Gaebalzarang
//
//  Created by Zeto on 2022/11/18.
//

import RxSwift
import RxCocoa

final class AuthenticationViewModel: ViewModel {

    struct Input {
        let typedPhoneValue: Driver<String?>
        let tapRequestAuthenticButton: Driver<Void>

        let typedAuthenticValue: Driver<String?>
        let tapConfirmAuthenticButton: Driver<Void>

        let tapNextButton: Driver<Void>
    }

    struct Output {
        let isPushedPhoneNumberRelay = PublishRelay<Bool>()
        let isCorrectAuthenticRelay = PublishRelay<Bool>()
        let canMoveToNextRelay = PublishRelay<Bool>()
    }

    private let output = Output()
    private let disposeBag = DisposeBag()

    private var typedPhoneNumber: String?
    private var typedAuthenticNumber: String?

    init() {

    }

    func transform(input: Input) -> Output {
        input.typedPhoneValue
            .drive { [weak self] phoneNum in
                self?.typedPhoneNumber = phoneNum
            }
            .disposed(by: disposeBag)
        
        input.tapRequestAuthenticButton
            .drive { [weak self] _ in
                // TODO: 입력 전화번호 서버에 넘겨주는 통신 구현 관련 Usecase
                
                self?.output.isPushedPhoneNumberRelay.accept(true)
            }
            .disposed(by: disposeBag)
        
        input.typedAuthenticValue
            .drive { [weak self] authenticValue in
                self?.typedAuthenticNumber = authenticValue
            }
            .disposed(by: disposeBag)
        
        input.tapConfirmAuthenticButton
            .drive { [weak self] _ in
                // TODO: 입력 인증번호 서버에 넘겨주는 통신 구현 관련 Usecase
                // 서버 response 값에 따라 Bool 값 변경하여 전달
                self?.output.isCorrectAuthenticRelay.accept(true)
                self?.output.canMoveToNextRelay.accept(true)
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
