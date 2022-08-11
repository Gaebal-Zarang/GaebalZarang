//
//  ProfilePositionViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/10.
//

import UIKit
import RxCocoa
import RxSwift

class ProfilePositionViewController: UIViewController {

    let disposebag = DisposeBag()
    let mainPositionObservable = Observable.of(["기획", "디자인", "개발"])
    let subPositionObservable = PublishSubject<[String]>()

    let sampleDict: [String: [String]] = ["기획": ["게임기획"],
                                          "디자인": ["UI디자이너", "UX디자이너"],
                                          "개발": ["프론트엔드", "백엔드", "iOS", "안드로이드", "데이터엔지니어", "AI"]]

    private var isSelectMainPosition = false
    // cell size 계산을 위한 프로퍼티
    var tempLabelText: [String] = ["기획", "디자인", "개발"]

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "포지션을\n선택해주세요.", isRequire: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var mainCategoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PositionCell.self, forCellWithReuseIdentifier: PositionCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var dividingLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gzGray1
        view.isHidden = true
        return view
    }()

    private var subCategoryCollectionView: UICollectionView = {
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PositionCell.self, forCellWithReuseIdentifier: PositionCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()

    private lazy var nextButton: CustomButton = {
        let button = CustomButton()
        let cornerRadius = DesignGuide.estimateWideViewCornerRadius(frame: view.frame)
        button.setCornerRound(value: cornerRadius)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // MARK: 메인포지션 Datasource bind
        mainPositionObservable
            .bind(to: mainCategoryCollectionView.rx
                .items(cellIdentifier: PositionCell.reuseIdentifier, cellType: PositionCell.self)) { [weak self] _, title, cell in
                    cell.set(text: title)
                    let radius = DesignGuide.estimateWideViewCornerRadius(frame: self?.view.frame ?? CGRect.zero)
                    cell.layer.cornerRadius = radius
                }
                .disposed(by: disposebag)

        // MARK: 메인포지션 Delegate bind
        mainCategoryCollectionView.rx.modelSelected(String.self)
            .bind { [weak self] title in
                self?.subCategoryCollectionView.isHidden = false
                self?.dividingLineView.isHidden = false
                guard let data = self?.sampleDict[title] else { return }
                self?.subPositionObservable.onNext(data)
                self?.isSelectMainPosition = true
                self?.tempLabelText = data

            }.disposed(by: disposebag)

        mainCategoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposebag)

        // MARK: 서브포지션 Datasource bind
        subPositionObservable
            .bind(to: subCategoryCollectionView.rx
                .items(cellIdentifier: PositionCell.reuseIdentifier, cellType: PositionCell.self)) { [weak self] _, title, cell in
                    cell.set(text: title)
                    let radius = DesignGuide.estimateWideViewCornerRadius(frame: self?.view.frame ?? CGRect.zero)
                    cell.layer.cornerRadius = radius
                }
                .disposed(by: disposebag)

        subCategoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposebag)

        configureLayout()

    }
}

private extension ProfilePositionViewController {

    func configureLayout() {
        view.addSubviews(inputTitleView, mainCategoryCollectionView, dividingLineView, subCategoryCollectionView, nextButton)

        let defaultHeight = DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame)

        // MARK: inputTitleView Constraints
        let inputTitleTopConstraint = DesignGuide.estimateYAxisLength(origin: 17, frame: view.frame)
        let inputTitleLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 35, frame: view.frame)

        NSLayoutConstraint.activate([
            inputTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inputTitleTopConstraint),
            inputTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inputTitleLeadingConstraint)
        ])

        // MARK: mainCategory CollectionView Constraints
        let mainCategoryTopConstraint = DesignGuide.estimateYAxisLength(origin: 30, frame: view.frame)
        let mainCategoryLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame)

        NSLayoutConstraint.activate([
            mainCategoryCollectionView.topAnchor.constraint(equalTo: inputTitleView.bottomAnchor, constant: mainCategoryTopConstraint),
            mainCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: mainCategoryLeadingConstraint),
            mainCategoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -mainCategoryLeadingConstraint),
            mainCategoryCollectionView.heightAnchor.constraint(equalToConstant: defaultHeight)
        ])

        let divideViewTopConstaint = DesignGuide.estimateYAxisLength(origin: 22, frame: view.frame)

        NSLayoutConstraint.activate([
            dividingLineView.topAnchor.constraint(equalTo: mainCategoryCollectionView.bottomAnchor, constant: divideViewTopConstaint),
            dividingLineView.leadingAnchor.constraint(equalTo: mainCategoryCollectionView.leadingAnchor),
            dividingLineView.trailingAnchor.constraint(equalTo: mainCategoryCollectionView.trailingAnchor),
            dividingLineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        // MARK: nextButton Constraints
        let nextBtnBottomConstraint = -(DesignGuide.estimateYAxisLength(origin: 24, frame: view.frame))

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: nextBtnBottomConstraint),
            nextButton.heightAnchor.constraint(equalToConstant: defaultHeight),
            nextButton.leadingAnchor.constraint(equalTo: mainCategoryCollectionView.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: mainCategoryCollectionView.trailingAnchor)
        ])

        // MARK: subCategory CollectionView Constraints
        let subCategoryTopConstraint = DesignGuide.estimateYAxisLength(origin: 22, frame: view.frame)

        NSLayoutConstraint.activate([
            subCategoryCollectionView.topAnchor.constraint(equalTo: dividingLineView.bottomAnchor, constant: subCategoryTopConstraint),
            subCategoryCollectionView.leadingAnchor.constraint(equalTo: mainCategoryCollectionView.leadingAnchor),
            subCategoryCollectionView.trailingAnchor.constraint(equalTo: mainCategoryCollectionView.trailingAnchor),
            subCategoryCollectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10)
        ])

    }
}

extension ProfilePositionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let tempLabel: UILabel = UILabel()

        let height = floor(DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame))
        // text 양쪽에 간격을 주기 위한 값
        let padding = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame) * 2

        tempLabel.text = self.tempLabelText[indexPath.item]
        tempLabel.sizeToFit()
        return CGSize(width: (tempLabel.frame.width+padding), height: height) // 간격포함
    }

}
