//
//  CompleteViewController.swift
//  iOS-Gaebalzarang
//
//  Created by juntaek.oh on 2022/08/10.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class CompleteViewController: UIViewController {

    private var titleImageView: UIImageView = .init().then {
        $0.image = UIImage(named: "signUpImage")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
    }

    private var titleLabel: UILabel = .init().then {
        $0.text = "가입되셨습니다."
        $0.textAlignment = .center
        $0.textColor = .black
        $0.sizeToFit()
    }

    private var descriptionLabel: UILabel = .init().then {
        $0.text = "가입해주셔서 감사합니다.\n로그인 후 서비스를 이용 해주시면 됩니다."
        $0.textAlignment = .center
        $0.textColor = .gzChacoal
        $0.numberOfLines = 2
        $0.sizeToFit()
    }

    private var confirmButton: CustomWideButton = .init(isEnabled: true).then {
        $0.setTitle("확인", for: .normal)
    }

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureNavigationItem()
        configureLayouts()
        configureInnerActionBinding()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.configureCornerRadius()
    }
}

private extension CompleteViewController {

    func configureNavigationItem() {
        navigationController?.navigationBar.isHidden = true
    }

    func configureLayouts() {
        view.addSubviews(titleImageView, titleLabel, descriptionLabel, confirmButton)

        titleImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(85)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(180)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.centerX.equalToSuperview()
        }

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(24)
            make.leading.trailing.equalToSuperview().inset(26)
            make.height.equalTo(50)
        }
    }

    func configureCornerRadius() {
        confirmButton.setCornerRound(value: (confirmButton.frame.height / 2))
    }
}

private extension CompleteViewController {

    func configureInnerActionBinding() {
        confirmButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.navigationController?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
