//
//  ProfilePositionViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/08/10.
//

import UIKit

class ProfilePositionViewController: UIViewController {

    let sampleCategory = ["기획", "디자인", "개발"]

    private var inputTitleView: InputTitleView = {
        let view = InputTitleView(text: "포지션을\n선택해주세요.", isRequire: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var mainCategoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PositionCell.self, forCellWithReuseIdentifier: PositionCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var nextButton: CustomButton = {
        let button = CustomButton()
        let cornerRadius = DesignGuide.estimateCornerRadius(origin: 50, frame: view.frame)
        button.setCornerRound(value: cornerRadius)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.isEnabled = true
//        button.addTarget(self, action: #selector(touchedNextButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainCategoryCollectionView.dataSource = self
        mainCategoryCollectionView.delegate = self
        configureLayout()

    }
}

private extension ProfilePositionViewController {

    func configureLayout() {
        view.addSubviews(inputTitleView, mainCategoryCollectionView)

        // MARK: inputTitleView Constraints
        let inputTitleTopConstraint = DesignGuide.estimateYAxisLength(origin: 17, frame: view.frame)
        let inputTitleLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 35, frame: view.frame)

        NSLayoutConstraint.activate([
            inputTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inputTitleTopConstraint),
            inputTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inputTitleLeadingConstraint)
        ])

        let mainCategoryTopConstraint = DesignGuide.estimateYAxisLength(origin: 30, frame: view.frame)
        let mainCategoryLeadingConstraint = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame)
        let mainCategoryHeightConstraint = floor(DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame))

        NSLayoutConstraint.activate([
            mainCategoryCollectionView.topAnchor.constraint(equalTo: inputTitleView.bottomAnchor, constant: mainCategoryTopConstraint),
            mainCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: mainCategoryLeadingConstraint),
            mainCategoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -mainCategoryLeadingConstraint),
            mainCategoryCollectionView.heightAnchor.constraint(equalToConstant: mainCategoryHeightConstraint)
        ])
    }
}

extension ProfilePositionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleCategory.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PositionCell.reuseIdentifier, for: indexPath)  as? PositionCell else { return UICollectionViewCell() }
        cell.set(text: sampleCategory[indexPath.item])
        let radius = DesignGuide.estimateCornerRadius(origin: 50, frame: view.frame)
        cell.layer.cornerRadius = radius
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tempLabel: UILabel = UILabel()

        let height = floor(DesignGuide.estimateYAxisLength(origin: 50, frame: view.frame))
        let padding = DesignGuide.estimateXAxisLength(origin: 25, frame: view.frame) * 2
        tempLabel.text = sampleCategory[indexPath.item]
        tempLabel.sizeToFit()

        return CGSize(width: (tempLabel.frame.width+padding), height: height) // 간격포함
    }

}
