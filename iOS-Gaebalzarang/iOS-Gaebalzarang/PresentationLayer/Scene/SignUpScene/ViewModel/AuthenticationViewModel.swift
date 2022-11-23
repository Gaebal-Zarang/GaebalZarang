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

    private var typedPhoneNumber: String?
    private var typedAuthenticNumber: String?

    init() {

    }

    func transform(input: Input) -> Output {

        return output
    }
}
