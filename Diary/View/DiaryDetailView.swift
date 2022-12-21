//
//  DiaryDetailView.swift
//  Diary
//
//  Created by junho lee on 2022/12/20.
//

import UIKit

final class DiaryDetailView: UIView {
    private let titleTextField = UITextField()
    private let bodyTextView = UITextView()
    private let stackView = UIStackView()
    private let isEditable: Bool
    var diary: Diary? {
        didSet {
            configureSubviewsText(with: diary)
        }
    }

    init(diary: Diary?, isEditable: Bool) {
        self.diary = diary
        self.isEditable = isEditable
        super.init(frame: .zero)
        backgroundColor = .white
        configureSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubViews() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.font = UIFont.preferredFont(forTextStyle: .title3)
        titleTextField.adjustsFontForContentSizeCategory = true
        titleTextField.isUserInteractionEnabled = isEditable
        titleTextField.placeholder = "Title"
        stackView.addArrangedSubview(titleTextField)

        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.font = UIFont.preferredFont(forTextStyle: .title3)
        bodyTextView.adjustsFontForContentSizeCategory = true
        bodyTextView.textContainer.lineFragmentPadding = 0
        bodyTextView.isEditable = isEditable
        stackView.addArrangedSubview(bodyTextView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureSubviewsText(with diary: Diary?) {
        guard let diary = diary else {
            titleTextField.text = nil
            bodyTextView.text = nil
            return
        }
        titleTextField.text = diary.title
        bodyTextView.text = diary.body
    }
}
