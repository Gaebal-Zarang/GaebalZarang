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
    
    private let output = Output()
    private let disposeBag = DisposeBag()

    init() {
        
    }
    
    func transform(input: Input) -> Output {
        
        return output
    }
}
