//
//  DiaryListViewController.swift
//  Diary
//
//  Created by junho lee on 2022/12/20.
//

import UIKit

final class DiaryListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Diary.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Diary.ID>
    var dataSource: DataSource!
    var diaries: [Diary] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureDiariesWithSampleData()
        configureCollectionViewLayout()
        configureDatasource()
//        updateSnapshot()
    }
}

extension DiaryListViewController {
    private func configureDiariesWithSampleData() {
        guard let sampleData = NSDataAsset(name: "sample")?.data,
              let sampleDiaries = try? JSONDecoder().decode([Diary].self, from: sampleData) else {
            return
        }
        diaries = sampleDiaries
    }

    private func configureNavigationItem() {
        navigationItem.title = "일기장"

        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = button
    }

    private func configureCollectionViewLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(75))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }

    private func configureDatasource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Diary.ID> { [weak self] cell, _, diaryID in
            var configuration = cell.diaryListConfiguration()

            guard let diary = self?.diary(for: diaryID) else {
                cell.contentConfiguration = configuration
                return
            }
            configuration.title = diary.title
            configuration.body = diary.body
            configuration.createdAt = diary.createdAt
            cell.contentConfiguration = configuration

            cell.accessories = [ UICellAccessory.disclosureIndicator(displayed: .always) ]
        }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, diaryID in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: diaryID)
        }
    }

    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(diaries.map { $0.id })
        dataSource.apply(snapshot)
    }

    private func diary(for id: Diary.ID) -> Diary? {
        return diaries.first(where: { diary in diary.id == id })
    }
}
