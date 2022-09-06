//
//  SkillViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/22.
//

import UIKit
import RxCocoa
import RxSwift

final class SkillViewController: UIViewController {

    let disposeBag = DisposeBag()
    let userSkillObservable = BehaviorRelay(value: [String]())

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "사용하는 언어나\n선호하는 협업 툴을\n작성해주세요.", isRequire: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var textField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let viewRound = DesignGuide.estimateWideViewCornerRadius(frame: self.view.frame)
        textField.setCornerRound(value: viewRound)
        textField.placeholder = "입력"
        textField.delegate = self
        return textField
    }()

    private var collectionView: UICollectionView = {
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SkillCell.self, forCellWithReuseIdentifier: SkillCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var nextButton: CustomWideButton = {
        let button = CustomWideButton()
        let cornerRadius = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        button.setCornerRound(value: cornerRadius)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.isEnabled = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureInnerActionBinding()
        configureLayout()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension SkillViewController {

    func configureInnerActionBinding() {

        userSkillObservable
            .bind(to: collectionView.rx
                .items(cellIdentifier: SkillCell.reuseIdentifier, cellType: SkillCell.self)) { [weak self] _, title, cell in
                    cell.set(text: title)

                    let radius =
                    DesignGuide.estimateNarrowViewCornerRadius(frame: self?.view.frame ?? CGRect.zero)
                    cell.layer.cornerRadius = radius
                }
                .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

    }

}

private extension SkillViewController {

    func configureLayout() {
        view.addSubviews(inputTitleView, textField, collectionView, nextButton)

        let defaultHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)

        // MARK: inputTitleView Constraints
        let inputTitleTopConstraint = DesignGuide.estimateYAxisLength(origin: 17, frame: view.frame)
        let inputTitleLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 35, frame: view.frame)

        NSLayoutConstraint.activate([
            inputTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inputTitleTopConstraint),
            inputTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inputTitleLeadingConstraint)
        ])

        let textFieldTopConstraint = DesignGuide.estimateYAxisLength(origin: 35, frame: view.frame)
        let textFieldLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: inputTitleView.bottomAnchor, constant: textFieldTopConstraint),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: textFieldLeadingConstraint),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -textFieldLeadingConstraint),
            textField.heightAnchor.constraint(equalToConstant: defaultHeight)
        ])

        let nextBtnBottomConstraint = -(DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame))

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: nextBtnBottomConstraint),
            nextButton.heightAnchor.constraint(equalToConstant: defaultHeight),
            nextButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])

        let collectionViewTopConstraint = DesignGuide.estimateYAxisLength(origin: 20, frame: view.frame)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: collectionViewTopConstraint),
            collectionView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20)
        ])

    }
}

// MARK: TextField Delegate
extension SkillViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true  }
        userSkillObservable.accept(userSkillObservable.value + [text])
        textField.text = ""
        return true
    }
}

extension SkillViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let tempLabel: UILabel = UILabel()

        let height = floor(DesignGuide.estimateYAxisLength(origin: 30, frame: view.frame))

        let padding = DesignGuide.estimateXAxisLength(origin: 18, frame: view.frame) * 2
        tempLabel.text = userSkillObservable.value[indexPath.item]
        tempLabel.sizeToFit()
        return CGSize(width: (tempLabel.frame.width+padding), height: height)
    }

}
