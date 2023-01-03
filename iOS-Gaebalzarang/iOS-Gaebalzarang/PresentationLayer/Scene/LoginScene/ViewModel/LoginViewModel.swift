//
//  LoginViewModel.swift
//  iOS-Gaebalzarang
//
//  Created by Zeto on 2022/11/15.
//

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModel {

    struct Input {
        let typedIdValue: Driver<String?>
        let typedPswValue: Driver<String?>
        let tappedLoginButton: Driver<Void>
    }

    struct Output {
        let canLoginRelay = PublishRelay<Bool>()
    }

    private let output = Output()
    private let disposeBag = DisposeBag()
    // TODO: 로그인, 회원가입 입력 값 저장 시에 사용될 Dictionary 키 값들을 enum으로 따로 분리 필요
    private var typedIdPw = ["ID": "", "PW": ""]

    init() {
        self.bindWithUsecase()
    }

    func transform(input: Input) -> Output {
        Observable.combineLatest(input.typedIdValue.asObservable(), input.typedPswValue.asObservable()) { idValue, pswValue in
            let id = (idValue != nil) ? idValue : ""
            let psw = (pswValue != nil) ? pswValue : ""

            return (id, psw)
        }
        .subscribe { [weak self] tuple in
            self?.typedIdPw["ID"] = tuple.0
            self?.typedIdPw["PW"] = tuple.1
        }
        .disposed(by: disposeBag)

        input.tappedLoginButton
            .drive { [weak self] _ in
                // TODO: Usecase를 통해서 로그인 가능 여부 받아오기 (typeIdPw 값 전달)
            }
            .disposed(by: disposeBag)

        return output
    }
}

private extension LoginViewModel {

    func bindWithUsecase() {
        // TODO: Login 가능 여부 Usecase에서 받아오면 해당 값과 canLoginRelay bind
        self.output.canLoginRelay
            .accept(false)
    }
}
