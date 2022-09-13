//
//  MainViewController.swift
//  iOS-Gaebalzarang
//
//  Created by 최예주 on 2022/09/02.
//

import UIKit
import RxCocoa
import RxSwift

enum MainSection: Int {
    case header
    case project
    case collaborator
}

final class MainViewController: UIViewController {

//    typealias MainDataSource = UICollectionViewDiffableDataSource<MainSection, MainSectionItem>

    let disposeBag = DisposeBag()
    let recommendProjectObservable = Observable.of([" ", " ", " ", " "])

//    var dataSource: MainDataSource! = nil

    private lazy var collectionView: UICollectionView = {
        guard let compositionalLayout = self.makeCompositionalLayout() else { return UICollectionView() }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(MainHeaderCell.self, forCellWithReuseIdentifier: MainHeaderCell.reuseIdentifier)

        collectionView.register(ProjectHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProjectHeaderView.reuseIdentifier)
        collectionView.register(RecommandProjectCell.self, forCellWithReuseIdentifier: RecommandProjectCell.reuseIdentifier)

        collectionView.register(CollaboratorHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollaboratorHeaderView.reuseIdentifier)
        collectionView.register(CollaboratorCell.self, forCellWithReuseIdentifier: CollaboratorCell.reuseIdentifier)

        return collectionView
    }()

    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout? {

        let layout = UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
            guard let section = MainSection(rawValue: section) else { return nil }
            switch section {
            case .header:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(172)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(172)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .none
                return section

            case .project:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(212), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 24)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(2.5), heightDimension: .absolute(250)), subitems: [item])

                group.interItemSpacing = .fixed(12)
                group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous

                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)

                section.boundarySupplementaryItems = [header]

                return section

            case .collaborator:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(62)))

//                vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1), subitems: [item]))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item, count: 10)
                group.interItemSpacing = .fixed(22)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none

                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)

                section.boundarySupplementaryItems = [header]

                return section

            }

        }
        return layout
    }

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        configureLayout()

    }

//    func setDatasource() {
//        dataSource = MainDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            switch itemIdentifier {
//
//            case .header(_):
//                guard let cell: MainHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainHeaderCell.reuseIdentifier, for: indexPath) as? MainHeaderCell else { return UICollectionViewCell() }
//                return cell
//            case .project(_):
//                guard let cell: RecommandProjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandProjectCell.reuseIdentifier, for: indexPath) as? RecommandProjectCell else { return UICollectionViewCell() }
//                return cell
//            case .collaborator(_):
//                guard let cell: CollaboratorCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollaboratorCell.reuseIdentifier, for: indexPath) as? CollaboratorCell else { return UICollectionViewCell() }
//                return cell
//            }
//        })
//
//        var snapshot = NSDiffableDataSourceSnapshot<MainSection,MainSectionItem>()
//
//        snapshot.appendSections([MainSection(id: "header"), MainSection(id: "project"), MainSection(id: "collaborator")])
//
//        snapshot.appendItems([.header()
//
//
//    }

    // MARK: viewDidAppear
//    override func viewDidAppear(_ animated: Bool) {
//        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? RecommandProjectCell else { return }
//        collectionView.visibleCells.forEach { guard let cell = $0 as? RecommandProjectCell else { return }
//        cell.thumbImageView.setTransparentGradient(bounds: cell.thumbImageView.bounds)
//        }
//        cell.layoutIfNeeded()
//    }

}

private extension MainViewController {

    func configureLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MainSection(rawValue: section)
        switch section {
        case .header:
            return 1
        case .project:
            return 5
        case .collaborator:
            return 10
        case .none:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = MainSection(rawValue: indexPath.section)
        switch section {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainHeaderCell.reuseIdentifier, for: indexPath) as? MainHeaderCell else { return UICollectionViewCell() }
            return cell
        case .project:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandProjectCell.reuseIdentifier, for: indexPath) as? RecommandProjectCell else { return UICollectionViewCell() }
            return cell
        case .collaborator:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollaboratorCell.reuseIdentifier, for: indexPath) as? CollaboratorCell else { return UICollectionViewCell() }
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = MainSection(rawValue: indexPath.section)

        if kind == UICollectionView.elementKindSectionHeader {
            switch section {

            case .project:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProjectHeaderView.reuseIdentifier, for: indexPath) as? ProjectHeaderView else { return UICollectionReusableView() }
                return headerView
            case .collaborator:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollaboratorHeaderView.reuseIdentifier, for: indexPath) as? CollaboratorHeaderView else { return UICollectionReusableView() }
                return headerView
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()

    }

}
