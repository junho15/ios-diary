//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by junho lee on 2022/12/21.
//

import UIKit

final class DiaryDetailViewController: UIViewController {
    private let diaryDetailView: DiaryDetailView
    private var diary: Diary?

    init(diary: Diary?, isEditable: Bool) {
        self.diary = diary
        diaryDetailView = DiaryDetailView(diary: diary, isEditable: isEditable)
        diaryDetailView.diary = diary
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationItem()
        configureSubViews()
    }

    private func configureNavigationItem() {
        if let createdAt = diary?.createdAt {
            let date = Date(timeIntervalSince1970: TimeInterval(createdAt))
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.locale = Locale.preferredLocale
            let dateText = formatter.string(from: date)

            navigationItem.title = dateText
        } else {
            navigationItem.title = nil
        }
    }

    private func configureSubViews() {
        diaryDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(diaryDetailView)

        let safeArea = view.safeAreaLayoutGuide
        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            diaryDetailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            diaryDetailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: spacing),
            diaryDetailView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -spacing),
            diaryDetailView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        ])
    }
}
