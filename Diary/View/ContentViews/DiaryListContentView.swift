//
//  DiaryListContentView.swift
//  Diary
//
//  Created by junho lee on 2022/12/20.
//

import UIKit

final class DiaryListContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var title: String?
        var body: String?
        var createdAt: Double?

        func makeContentView() -> UIView & UIContentView {
            return DiaryListContentView(self)
        }

        func updated(for state: UIConfigurationState) -> DiaryListContentView.Configuration {
            return self
        }
    }

    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let createdAtLabel = UILabel()
    private let bodyLabel = UILabel()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        titleLabel.text = configuration.title
        bodyLabel.text = configuration.body
        configureCreatedAtLabelText(with: configuration.createdAt)
    }

    private func configureCreatedAtLabelText(with createdAt: Double?) {
        guard let createdAt = createdAt else {
            createdAtLabel.text = nil
            return
        }
        let date = Date(timeIntervalSince1970: TimeInterval(createdAt))

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale.preferredLocale
        let dateText = formatter.string(from: date)

        createdAtLabel.text = dateText
    }

    private func configureSubViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 1
        addSubview(titleLabel)

        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.font = UIFont.preferredFont(forTextStyle: .body)
        createdAtLabel.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(createdAtLabel)

        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bodyLabel.adjustsFontForContentSizeCategory = true
        bodyLabel.numberOfLines = 1
        stackView.addArrangedSubview(bodyLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        addSubview(stackView)

        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
        createdAtLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
    }
}

extension UICollectionViewCell {
    func diaryListConfiguration() -> DiaryListContentView.Configuration {
        return DiaryListContentView.Configuration()
    }
}
