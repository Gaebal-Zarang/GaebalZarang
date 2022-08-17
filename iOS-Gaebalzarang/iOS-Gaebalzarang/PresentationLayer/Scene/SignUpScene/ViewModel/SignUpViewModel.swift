//
//  SignUpViewModel.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import Foundation
import RxSwift
import RxRelay

final class SignUpViewModel {

    struct Input {
        let validationCheckEvent: Observable<String>
    }

    struct Output {
        let validationSubject = PublishRelay<ValidationCheckCase>()
    }

    let idCheckUsecase: CheckValidityUsecase

    init(idUsecase: CheckValidityUsecase) {
        self.idCheckUsecase = idUsecase
    }

    convenience init() {
        self.init(idUsecase: CheckUserIdValidityUsecase())
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        input.validationCheckEvent
            .subscribe { [weak self] text in
                guard let validation = self?.idCheckUsecase.executeValidation(with: text) else { return }
                output.validationSubject.accept(validation)

            } onError: { _ in
                return
            }
            .disposed(by: disposeBag)

        return output
    }
}
