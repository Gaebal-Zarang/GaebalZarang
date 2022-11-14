//
//  LoginViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/08.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

// TODO: 텍스트 필드를 가진 모든 VC에서 키보드 올라오면 뷰도 같이 올라가고, 바깥을 터치하면 키보드 해제되는 기능 구현 필요
class LoginViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureLayouts()
        configureInnerActionBinding()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        configureCornerRound()
    }
}

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

    func configureStackSubViews() {
        for num in 0...1 {
            let textField = CustomTextField().then {
                if num == 0 {
                    $0.placeholder = "ID"

                } else {
                    $0.placeholder = "PW"
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
                $0.sizeToFit()
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

    func configureCornerRound() {
        idPwTextFields.forEach {
            $0.setCornerRound(value: ($0.frame.height / 2))
        }

        loginButton.setCornerRound(value: (loginButton.frame.height / 2))
    }

    func configureInnerActionBinding() {

    }
}
