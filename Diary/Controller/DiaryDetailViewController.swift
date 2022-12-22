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
    private var keyboardConstraint: NSLayoutConstraint!

    init(diary: Diary?, isEditable: Bool) {
        self.diary = diary
        diaryDetailView = DiaryDetailView(diary: diary, isEditable: isEditable)
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

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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

        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            diaryDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            diaryDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing),
            diaryDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing)
        ])
        keyboardConstraint = diaryDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        keyboardConstraint.isActive = true
    }
}

extension DiaryDetailViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ sender: NSNotification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                  return
              }
        keyboardConstraint.constant = -keyboardFrame.cgRectValue.height
    }

    @objc private func keyboardWillHide(_ sender: Notification) {
        keyboardConstraint.constant = 0
    }
}
