//
//  LoginViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Then
import SnapKit

final class LoginViewController: UIViewController {

    let disposeBag = DisposeBag()

    private let logoView = UIImageView().then {
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
    }

    private let idPwStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }

    private let showButton = UIButton().then {
        $0.setTitle("Show", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.setTitleColor(.gzGreen, for: .normal)
    }

    private let searchStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
    }

    private let loginButton = CustomWideButton(isEnabled: true).then {
        $0.setTitle("로그인", for: .normal)
    }

    private var idPwTextFields = [CustomTextField]()
    private var searchButtons = [UIButton]()

    private let loginVM: LoginViewModel

    init(with viewModel: LoginViewModel) {
        self.loginVM = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setContentView()
        configureLayouts()
        bindWithViewModel()
        bindWithInnerAction()
    }

    // Auto layout 사용 시, cornerRadius 해결 가능한 생명 주기 메서드
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        configureCornerRound()
    }
}

// MARK: Set view attributes and Bind Action
private extension LoginViewController {

    func setContentView() {
        self.view.backgroundColor = .white
    }

    func bindWithViewModel() {
        guard let idText = idPwTextFields[safe: 0], let pwText = idPwTextFields[safe: 1] else { return }

        let input = LoginViewModel.Input(typedIdValue: idText.rx.value.asObservable(), typedPswValue: pwText.rx.value.asObservable(), tappedLoginButton: loginButton.rx.tap.asObservable())
        let output = loginVM.transform(input: input)

        output.canLoginRelay
            .subscribe { [weak self] _ in
                // TODO: canLogin 값에 따라 toastLabel or 홈화면 이동
            }
            .disposed(by: disposeBag)
    }

    func bindWithInnerAction() {
        guard let search = searchButtons[safe: 0], let signUp = searchButtons[safe: 1] else { return }

        self.view.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)

        // PW show 버튼 클릭 시, 값을 보여줄 지 안 보여줄 지 토글
        self.showButton.rx.tap
            .bind { [weak self] _ in
                if let pwText = self?.idPwTextFields[safe: 1] {
                    pwText.isSecureTextEntry.toggle()
                }
            }
            .disposed(by: disposeBag)

        search.rx.tap
            .bind { [weak self] _ in
                // TODO: 아이디 비밀번호 찾기 Scene 이동
            }
            .disposed(by: disposeBag)

        signUp.rx.tap
            .bind { [weak self] _ in
                // TODO: 회원가입 Scene 이동
                let signUpVC = SignUpViewController()
                signUpVC.modalPresentationStyle = .fullScreen
                self?.present(signUpVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: Configure layout
private extension LoginViewController {

    func configureLayouts() {
        view.addSubviews(logoView, idPwStackView, showButton, searchStackView, loginButton)
        self.configureStackSubViews()

        logoView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(111)
            make.width.equalTo(150)
            make.height.equalTo(68)
            make.centerX.equalToSuperview()
        }

        idPwStackView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(74)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(112)
        }

        showButton.snp.makeConstraints { make in
            make.centerY.equalTo(idPwStackView.subviews[1].snp.centerY)
            make.trailing.equalTo(idPwStackView.snp.trailing).offset(-29)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }

        searchStackView.snp.makeConstraints { make in
            make.top.equalTo(idPwStackView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-29)
            make.width.equalTo(idPwStackView.snp.width)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    // 중복 뷰 할당으로 인한 코드 낭비 방지를 위한 함수
    func configureStackSubViews() {
        for num in 0...1 {
            let textField = CustomTextField().then {
                if num == 0 {
                    $0.placeholder = "ID"

                } else {
                    $0.placeholder = "PW"
                    $0.isSecureTextEntry = true
                    $0.addRightPadding(with: 75)
                }

                $0.setPlaceHolder()
                $0.sizeToFit()
            }

            let button = UIButton().then {
                if num == 0 {
                    $0.setTitle("아이디 비밀번호 찾기", for: .normal)

                } else {
                    $0.setTitle("회원가입", for: .normal)
                }

                $0.titleLabel?.textAlignment = .center
                $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
                $0.setTitleColor(.gzGray3, for: .normal)
            }

            idPwStackView.addArrangedSubview(textField)
            idPwTextFields.append(textField)

            searchStackView.addArrangedSubview(button)
            searchButtons.append(button)
        }

        let label = UILabel().then {
            $0.text = "/"
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .gzGray3
            $0.textAlignment = .center
            $0.sizeToFit()
        }

        searchStackView.insertArrangedSubview(label, at: 1)
    }

    // 높이 절반 값의 라운드 (둥근 모서리 뷰)
    func configureCornerRound() {
        idPwTextFields.forEach {
            $0.setCornerRound(value: ($0.frame.height / 2))
        }

        loginButton.setCornerRound(value: (loginButton.frame.height / 2))
    }
}
