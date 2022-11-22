//
//  SignUpViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Then
import SnapKit

final class SignUpViewController: UIViewController {

    private let verticalStackView = UIStackView().then {
        $0.spacing = 14
        $0.axis = .vertical
        $0.distribution = .fill
    }

    private let idConfirmButton = CustomNarrowButton(isEnabled: true).then {
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitle("중복 확인", for: .normal)
    }

    private let nextButton = CustomWideButton(isEnabled: false).then {
        $0.setTitle("다음", for: .normal)
    }

    private var signUpTextFields = [CustomTextField]()
    private var validationLabels = [UILabel]()

    private let signUpVM: SignUpViewModel
    private let disposeBag = DisposeBag()

    init(with viewModel: SignUpViewModel) {
        self.signUpVM = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setContentView()
        self.configureLayouts()
        self.setViewModelOutput()

        // MARK: 임시로 뷰 넘어가게끔 코드 작성
        nextButton.isEnabled = true
        nextButton.addTarget(self, action: #selector(justTest), for: .touchDown)
    }

    @objc
    func justTest() {
        let view = AuthenticationViewController()
        self.navigationController?.pushViewController(view, animated: true)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.configureCornerRadius()
    }
}

// MARK: Set view attributes and Bind Action
private extension SignUpViewController {

    func setContentView() {
        view.backgroundColor = .white
    }

    func setViewModelOutput() {
        guard let nameText = signUpTextFields[safe: 0], let idText = signUpTextFields[safe: 1], let pswText = signUpTextFields[safe: 2], let confirmText = signUpTextFields[safe: 3] else { return }

        let input = SignUpViewModel.Input(typedNameValue: nameText.rx.value.distinctUntilChanged(), typedIdValue: idText.rx.value.distinctUntilChanged(), typedPwValue: pswText.rx.value.distinctUntilChanged(), typedConfirmPwValue: confirmText.rx.value.distinctUntilChanged(), tappedConfirmIdButton: idConfirmButton.rx.tap.asObservable(), tappedNextButton: nextButton.rx.tap.asObservable())
        let output = signUpVM.transform(input: input)

        self.bindValidationTextField(with: output)
        self.bindButton(with: output)
        self.bindWithInnerAction()
    }

    // 유효성 검사 관련 경고 라벨 isHidden 바인딩
    func bindValidationTextField(with output: SignUpViewModel.Output) {
        output.validNameRelay
            .subscribe { [weak self] validate in
                guard let self = self, let nameLabel = self.validationLabels[safe: 0] else { return }

                nameLabel.isHidden = validate
            }
            .disposed(by: disposeBag)

        output.validIdRelay
            .subscribe { [weak self] validate in
                guard let self = self, let idLabel = self.validationLabels[safe: 1] else { return }

                idLabel.isHidden = validate
            }
            .disposed(by: disposeBag)

        output.validPwRelay
            .subscribe { [weak self] validate in
                guard let self = self, let pwLabel = self.validationLabels[safe: 2] else { return }

                pwLabel.isHidden = validate
            }
            .disposed(by: disposeBag)

        output.validConfirmPwRelay
            .subscribe { [weak self] validate in
                guard let self = self, let confirmLabel = self.validationLabels[safe: 3] else { return }

                confirmLabel.isHidden = validate
            }
            .disposed(by: disposeBag)
    }

    // 버튼 활성화 및 액션 바인딩
    func bindButton(with output: SignUpViewModel.Output) {
        output.isEnableNextButtonRelay
            .subscribe { [weak self] isEnable in
                self?.nextButton.isEnabled = isEnable
            }
            .disposed(by: disposeBag)

        output.isActiveConfirmIdButtonRelay
            .subscribe { [weak self] _ in
                // TODO: isActive 값에 따라 Toast 내용 변경?
            }
            .disposed(by: disposeBag)

        output.isActiveNextButtonRelay
            .subscribe { [weak self] _ in
                // TODO: isActive 값에 따라 오류 팝업 or 다음 화면 이동
            }
            .disposed(by: disposeBag)
    }

    func bindWithInnerAction() {
        self.view.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: Configure layout
private extension SignUpViewController {

    func configureLayouts() {
        self.view.addSubviews(verticalStackView, idConfirmButton, nextButton)
        for num in 0...3 {
            self.configureStackSubviews(index: num)
        }

        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(31)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.leading.equalTo(verticalStackView.snp.leading)
            make.trailing.equalTo(verticalStackView.snp.trailing)
            make.height.equalTo(50)
        }

        guard let emailTextField = self.signUpTextFields[safe: 1] else { return }

        idConfirmButton.snp.makeConstraints { make in
            make.width.equalTo(83)
            make.height.equalTo(26)
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.trailing.equalTo(emailTextField.snp.trailing).offset(-14)
        }
    }

    func configureCornerRadius() {
        self.nextButton.setCornerRound(value: (nextButton.frame.height / 2))
        self.idConfirmButton.setCornerRound(value: (idConfirmButton.frame.height / 2))
        self.signUpTextFields.forEach {
            $0.setCornerRound(value: ($0.frame.height / 2))
        }
    }
}

// MARK: Configure subViews layout of MainStackView
private extension SignUpViewController {

    func configureStackSubviews(index: Int) {
        let verticlaStack = UIStackView().then {
            $0.spacing = 7
            $0.alignment = .leading
            $0.distribution = .fill
            $0.axis = .vertical
        }
        let textField = CustomTextField()
        let label = CustomLabel().then {
            $0.isHidden = true
            $0.font = .systemFont(ofSize: 14)
            $0.numberOfLines = 1
            $0.sizeToFit()
            $0.textColor = .red
        }

        switch index {
        case 0:
            textField.placeholder = "이름"
            label.text = "이름은 2-3글자 한글로 입력해주세요"

        case 1:
            textField.placeholder = "E-mail"
            label.text = "올바른 이메일 형식으로 입력해주세요"

        case 2:
            textField.placeholder = "PW"
            textField.isSecureTextEntry = true
            label.numberOfLines = 2
            label.text = "8-16자 영문 대소문자, 숫자, 특수기호(!,@,#,$,%)를 모두 입력해주세요"

        case 3:
            textField.placeholder = "PW 재확인"
            textField.isSecureTextEntry = true
            label.text = "패스워드가 일치하지 않습니다"

        default:
            break
        }

        textField.setPlaceHolder()
        signUpTextFields.append(textField)
        validationLabels.append(label)

        verticlaStack.addArrangedSubviews(textField, label)
        self.verticalStackView.addArrangedSubview(verticlaStack)
        self.configureStackSubviewsLayout(with: textField)
    }

    func configureStackSubviewsLayout(with textField: UIView) {
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
    }
}
