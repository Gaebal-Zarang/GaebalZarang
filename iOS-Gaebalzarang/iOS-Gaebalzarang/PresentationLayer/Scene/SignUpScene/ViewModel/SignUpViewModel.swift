//
//  SignUpViewModel.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/17.
//

import RxSwift
import RxRelay

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
        let validNameRelay = BehaviorRelay<Bool>(value: true)
        let validIdRelay = BehaviorRelay<Bool>(value: true)
        let validPwRelay = BehaviorRelay<Bool>(value: true)
        let validConfirmPwRelay = BehaviorRelay<Bool>(value: true)

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

// MARK: Binding Usecase's observer and Output accept/onNext
private extension SignUpViewModel {

    // TODO: 차후 API Usecase의 Observer 값과 Output 바인딩 진행
    func bindToUsecase() {

    }
}

// MARK: Binding Input (with Output accept/onNext)
private extension SignUpViewModel {

    // 유효성 관련 바인딩
    func bindValidateObserver(with input: Input) {
        let inputDictionary: [ValidationCheckCase: Observable<String?>] = [.name: input.typedNameValue, .id: input.typedIdValue, .psw: input.typedPwValue, .confirm: input.typedConfirmPwValue]
        let outputDictionary: [ValidationCheckCase: BehaviorRelay<Bool>]  = [.name: output.validNameRelay, .id: output.validIdRelay, .psw: output.validPwRelay, .confirm: output.validConfirmPwRelay]

        self.operateObserver(with: inputDictionary, to: outputDictionary)
    }

    // 유효성 바인딩 중복 코드 방지를 위한 로직
    func operateObserver(with inputDictionary: [ValidationCheckCase: Observable<String?>], to outputDictionary: [ValidationCheckCase: BehaviorRelay<Bool>]) {

        inputDictionary.forEach { dic in
            dic.value
                .map { return ($0 != nil) ? $0! : "" }
                .subscribe { [weak self] value in
                    guard let self = self else { return }

                    switch dic.key {
                    case .psw:
                        self.typedPswString = value

                    default:
                        break
                    }

                    if dic.key == .confirm {
                        let validation = (value == self.typedPswString)
                        outputDictionary[dic.key]?.accept(validation)

                    } else {
                        guard value != "" else {
                            outputDictionary[dic.key]?.accept(true)

                            return
                        }

                        let validation = self.validateUsecase.execute(with: value, classify: dic.key)
                        outputDictionary[dic.key]?.accept(validation)
                    }
                }
                .disposed(by: disposeBag)
        }
    }

    // 버튼과 관련된 바인딩
    func bindButtonObserver(with input: Input) {
        // 유효성 검사 외에 값 자체가 빈 값("")인지도 같이 확인해서 Bool 방출
        Observable
            .combineLatest(input.typedNameValue.distinctUntilChanged(), input.typedIdValue.distinctUntilChanged(), input.typedPwValue.distinctUntilChanged(), input.typedConfirmPwValue.distinctUntilChanged(), output.validNameRelay.distinctUntilChanged(), output.validIdRelay.distinctUntilChanged(), output.validPwRelay.distinctUntilChanged(), output.validConfirmPwRelay.distinctUntilChanged(), resultSelector: { (nameString, idString, pswString, confirmString, name, id, psw, confirm) in
                let stringValues = [nameString, idString, pswString, confirmString]
                let isNotBlankTextField = !(stringValues.contains(""))

                return [name, id, psw, confirm, isNotBlankTextField]
            })
            .retry(3)
            .map { return !($0.contains(false)) }
            .bind(to: output.isEnableNextButtonRelay)
            .disposed(by: disposeBag)

        input.tappedConfirmIdButton
            .subscribe { [weak self] _ in
                // TODO: 아이디 중복 검사 로직 추가 (Usecase 실행)
                // 임시 코드
                self?.output.isActiveConfirmIdButtonRelay.accept(true)
            }
            .disposed(by: disposeBag)

        input.tappedNextButton
            .subscribe { [weak self] _ in
                // TODO: 회원가입 진행 결과 로직 추가 (Usecase 실행)
                // 임시 코드
                self?.output.isActiveNextButtonRelay.accept(true)
            }
            .disposed(by: disposeBag)
    }
}
