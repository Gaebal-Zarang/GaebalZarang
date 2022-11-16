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

final class SignUpViewModel: ViewModel {
    
    struct Input {
        let typedNameValue: Observable<String?>
        let typedIdValue: Observable<String?>
        let typedPwValue: Observable<String?>
        let typedConfirmPwValue: Observable<String?>
        
        let tappedConfirmIdButton: Observable<Void>
        let tappedNextButton: Observable<Void>
    }
    
    struct Output {
        let validNameRelay = BehaviorRelay<Bool>(value: false)
        let validIdRelay = BehaviorRelay<Bool>(value: false)
        let validPwRelay = BehaviorRelay<Bool>(value: false)
        let validConfirmPwRelay = BehaviorRelay<Bool>(value: false)
        
        let isEnableNextButtonRelay = PublishRelay<Bool>()
        let isActiveNextButtonRelay = PublishRelay<Bool>()
        let isActiveConfirmIdButtonRelay = PublishRelay<Bool>()
    }
    
    private let validateUsecase: CheckUsecase
    private let output = Output()
    private let disposeBag = DisposeBag()
    
    private var typedPswString = ""

    init(validateUsecase: CheckUsecase) {
        self.validateUsecase = validateUsecase
    }
    
    func transform(input: Input) -> Output {
        self.bindValidateObserver(with: input)
        self.bindButtonObserver(with: input)
        
        return output
    }
}

// MARK: Binding Input and Usecase's Output
private extension SignUpViewModel {
    
    // 유효성 관련 바인딩
    func bindValidateObserver(with input: Input) {
        input.typedNameValue
            .map { return ($0 != nil) ? $0! : "" }
            .subscribe { [weak self] value in
                guard let self = self else { return }
                
                let validation = self.validateUsecase.execute(with: value, classify: .name)
                self.output.validNameRelay.accept(validation)
            }
            .disposed(by: disposeBag)
        
        input.typedIdValue
            .map { return ($0 != nil) ? $0! : "" }
            .subscribe { [weak self] value in
                guard let self = self else { return }
                
                let validation = self.validateUsecase.execute(with: value, classify: .id)
                self.output.validIdRelay.accept(validation)
            }
            .disposed(by: disposeBag)
        
        input.typedPwValue
            .map { return ($0 != nil) ? $0! : "" }
            .subscribe { [weak self] value in
                guard let self = self else { return }
                
                let validation = self.validateUsecase.execute(with: value, classify: .psw)
                self.output.validPwRelay.accept(validation)
                
                if let value = value.element {
                    self.typedPswString = value
                }
            }
            .disposed(by: disposeBag)
        
        input.typedConfirmPwValue
            .map { return ($0 != nil) ? $0! : "" }
            .subscribe { [weak self] value in
                guard let self = self else { return }
                
                let validation = (value == self.typedPswString)
                self.output.validConfirmPwRelay.accept(validation)
            }
            .disposed(by: disposeBag)
    }
    
    // 버튼과 관련된 바인딩
    func bindButtonObserver(with input: Input) {
        Observable
            .combineLatest(output.validNameRelay.distinctUntilChanged(), output.validIdRelay.distinctUntilChanged(), output.validPwRelay.distinctUntilChanged(), output.validConfirmPwRelay.distinctUntilChanged(), resultSelector: { (name, id, psw, confirm) in
            
                return [name, id, psw, confirm]
            })
            .retry(3)
            .map { return !($0.contains(false)) }
            .bind(to: output.isEnableNextButtonRelay)
            .disposed(by: disposeBag)
        
        output.isActiveConfirmIdButtonRelay
            .subscribe { [weak self] _ in
                // TODO: 아이디 중복 검사 로직 추가
            }
            .disposed(by: disposeBag)
        
        output.isActiveNextButtonRelay
            .subscribe { [weak self] _ in
                // TODO: 회원가입 진행 결과 로직 추가
            }
            .disposed(by: disposeBag)
    }
}
