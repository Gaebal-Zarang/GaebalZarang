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

final class SignUpViewController: UIViewController {

    enum ValidConfirm {
        case nameValid
        case idValid
        case idUseable
        case pswValid
        case pswEqual
    }

    let signUpViewModel = SignUpViewModel()
    let disposeBag = DisposeBag()


    // TODO: ID 중복확인 추가 필요
    private var isNextButtonEnabled: [ValidConfirm: Bool] = [.nameValid: false, .idValid: false, .idUseable: false, .pswValid: false, .pswEqual: false] {

        willSet(newDictionary) {
            let trueValues = newDictionary.filter { $0.value == true }
            guard trueValues.count == 5 else { return }
            nextButton.isEnabled = true
        }
    }

    private lazy var nameIDView = SignUpNameIDView(with: view.frame)
    private lazy var passwordView = SignUpPasswordView(with: view.frame)

    private lazy var nextButton: CustomWideButton = {
        let btnRound = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        let button = CustomWideButton(isEnabled: false)
        button.setTitle("다음", for: .normal)
        button.setCornerRound(value: btnRound)
        // TODO: 유효성 검사 구현 시, isEnabled false로 변경
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationItem()
        configureLayouts()
        configureVMBinding()
        configureInnerActionBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureKeyboardNotification()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        isNextButtonEnabled.keys.forEach {
            isNextButtonEnabled[$0] = false
        }
        nextButton.isEnabled = false
        nameIDView.reset()
        passwordView.reset()
    }
}

private extension SignUpViewController {

    func configureNavigationItem() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gzGreen
        label.sizeToFit()

        navigationItem.titleView = label
        navigationItem.backButtonTitle = ""
    }

    func configureLayouts() {
        view.addSubviews(nameIDView, passwordView, nextButton)

        let viewWidth = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)
        let viewHeight = DesignGuide.estimateYAxisLength(origin: 146, frame: view.frame)
        let nameIDTopConstant = DesignGuide.estimateYAxisLength(origin: 21, frame: view.frame)

        NSLayoutConstraint.activate([
            nameIDView.widthAnchor.constraint(equalToConstant: viewWidth),
            nameIDView.heightAnchor.constraint(equalToConstant: viewHeight),
            nameIDView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: nameIDTopConstant),
            nameIDView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        let passwordTopConstant = DesignGuide.estimateYAxisLength(origin: 20, frame: view.frame)

        NSLayoutConstraint.activate([
            passwordView.widthAnchor.constraint(equalToConstant: viewWidth),
            passwordView.heightAnchor.constraint(equalToConstant: viewHeight),
            passwordView.topAnchor.constraint(equalTo: nameIDView.bottomAnchor, constant: passwordTopConstant),
            passwordView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        let buttonHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)
        let buttonBottomConstant = DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame)

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(buttonBottomConstant)),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: viewWidth),
            nextButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }

    func configureKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchKeyboardHeight), name: Notification.Name("KeyboardHeight"), object: nil)
        setKeyboardObserver()
    }

    @objc
    func fetchKeyboardHeight(notification: Notification) {
        guard let keyboardHeight = notification.userInfo?["KeyboardHeight"] as? CGFloat else { return }

        nameIDView.subviews.forEach {
            setViewBound(dueTo: keyboardHeight, with: $0)
        }

        passwordView.subviews.forEach {
            setViewBound(dueTo: keyboardHeight, with: $0)
        }
    }

    func configureVMBinding() {
        let input = SignUpViewModel.SignUpInput(nameValidationCheckEvent: nameIDView.setNameValid(), idValidationCheckEvent: nameIDView.setCheckingIDValid(), idUseableCheckEvent: nameIDView.setOverlapButtonAction(), pswValidationCheckEvent: passwordView.setCheckingPswValid(), pswEqualCheckEvent: passwordView.setCheckingPswEqual())
        let output = signUpViewModel.transform(input: input, disposeBag: disposeBag)

        output.nameValidationSubject
            .asDriver(onErrorJustReturn: .onError)
            .drive { [weak self] validation in
                switch validation.self {
                case .valid:
                    self?.isNextButtonEnabled[.nameValid] = true
                default:
                    self?.isNextButtonEnabled[.nameValid] = false
                }
            }
            .disposed(by: disposeBag)

        output.idValidationSubject
            .asDriver(onErrorJustReturn: .onError)
            .drive { [weak self] validation in
                switch validation.self {
                case .valid:
                    self?.isNextButtonEnabled[.idValid] = true
                    self?.nameIDView.checkValid(with: true)
                    self?.nameIDView.changeOverlapButton(isEnabled: true)
                case .inValid:
                    self?.isNextButtonEnabled[.idValid] = false
                    self?.nameIDView.checkValid(with: false)
                    self?.nameIDView.changeOverlapButton(isEnabled: false)
                case .idOverraped:
                    self?.isNextButtonEnabled[.idUseable] = false
                    self?.nameIDView.checkUseable(with: false)
                case .idUseable:
                    self?.isNextButtonEnabled[.idUseable] = true
                    self?.nameIDView.checkUseable(with: true)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)

        output.pswValidationSubject
            .asDriver(onErrorJustReturn: .onError)
            .drive { [weak self] validation in
                switch validation.self {
                case .valid:
                    self?.isNextButtonEnabled[.pswValid] = true
                    self?.passwordView.checkValid(with: true)
                case .inValid:
                    self?.isNextButtonEnabled[.pswValid] = false
                    self?.passwordView.checkValid(with: false)
                case .pswEqual:
                    self?.isNextButtonEnabled[.pswEqual] = true
                    self?.passwordView.checkEqual(with: true)
                case .pswNonEqual:
                    self?.isNextButtonEnabled[.pswEqual] = false
                    self?.passwordView.checkEqual(with: false)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }

    func configureInnerActionBinding() {
        nextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                let nextVC = AuthenticationViewController(viewModel: self.signUpViewModel)
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)

        view.rx.tapGesture()
            .asDriver()
            .drive { [weak self] _ in
                self?.nameIDView.findAndResignFirstResponder()
                self?.passwordView.findAndResignFirstResponder()
            }
            .disposed(by: disposeBag)
    }
}
