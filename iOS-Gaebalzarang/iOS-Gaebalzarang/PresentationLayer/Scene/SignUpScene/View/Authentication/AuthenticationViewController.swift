//
//  AuthenticationViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

// TODO: 인증 번호, 확인 버튼 isEnable false로 바꾸고 값 입력시 true로 변경
final class AuthenticationViewController: UIViewController {

    enum ValidConfirm {
        case phoneNumValid
        case authenticCodeValid
    }

    private var authenticViewModel: SignUpViewModel?
    let disposeBag = DisposeBag()

    private lazy var contentView = AuthenticationContentView(with: view.frame)

    private lazy var nextButton: CustomWideButton = {
        let btnRound = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        let button = CustomWideButton(isEnabled: false)
        button.setTitle("다음", for: .normal)
        button.setCornerRound(value: btnRound)
        // TODO: 유효성 검사 구현 시, isEnabled false로 변경
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private var isNextButtonEnabled: [ValidConfirm: Bool] = [.phoneNumValid: false, .authenticCodeValid: false] {
        willSet(newDictionary) {
            let trueValues = newDictionary.filter { $0.value == true }
            guard trueValues.count == 2 else { return }
            nextButton.isEnabled = true
        }
    }

    init(viewModel: SignUpViewModel) {
        self.authenticViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

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
    }
}

private extension AuthenticationViewController {

    func configureNavigationItem() {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gzGreen
        label.sizeToFit()

        navigationItem.titleView = label
    }

    func configureLayouts() {
        view.addSubviews(contentView, nextButton)

        let contentViewTopConstant = DesignGuide.estimateYAxisLength(origin: 26, frame: view.frame)
        let viewWidth = DesignGuide.estimateXAxisLength(origin: 322, frame: view.frame)
        let viewHeight = DesignGuide.estimateYAxisLength(origin: 152, frame: view.frame)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: contentViewTopConstant),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.widthAnchor.constraint(equalToConstant: viewWidth),
            contentView.heightAnchor.constraint(equalToConstant: viewHeight)
        ])

        let nextButtonHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)
        let buttonBottomConstant = DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame)

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(buttonBottomConstant)),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: viewWidth),
            nextButton.heightAnchor.constraint(equalToConstant: nextButtonHeight)
        ])
    }

    func configureKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchKeyboardHeight), name: Notification.Name("KeyboardHeight"), object: nil)
        setKeyboardObserver()
    }

    @objc
    func fetchKeyboardHeight(notification: Notification) {
        guard let keyboardHeight = notification.userInfo?["KeyboardHeight"] as? CGFloat else { return }

        contentView.subviews.forEach {
            setViewBound(dueTo: keyboardHeight, with: $0)
        }
    }

    func configureVMBinding() {
        let input = SignUpViewModel.AuthenticInput(phoneNumberCheckEvent: contentView.setPhoneNumberTexting(), authenticCodeCheckEvent: contentView.setAuthenticCode())
        let output = authenticViewModel?.transform(input: input, disposeBag: disposeBag)

        output?.phoneNumberSubject
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] bool in
                self?.contentView.changeAuthenticButton(isEnabled: bool)
                self?.isNextButtonEnabled[.phoneNumValid] = bool
            }
            .disposed(by: disposeBag)

        output?.authenticCodeValidationSubject
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] bool in
                self?.contentView.changeAuthenticCode(isValid: bool)
                self?.isNextButtonEnabled[.authenticCodeValid] = bool
            }
            .disposed(by: disposeBag)
    }

    func configureInnerActionBinding() {
        contentView.setReceiveCodeButtonAction()
            .drive { [weak self] _ in
                self?.contentView.tappedReceiveCodeButton()
                // TODO: Usecase - Repository 인증번호 요청 API 호출
            }
            .disposed(by: disposeBag)

        view.rx.tapGesture()
            .asDriver()
            .drive { [weak self] _ in
                self?.contentView.findAndResignFirstResponder()
            }
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let nextVC = CompleteViewController()
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
