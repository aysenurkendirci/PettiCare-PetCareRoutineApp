import UIKit

final class RoutineItemView: UIView {

    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let subtitleTapButton = UIButton()
    private let rightIconView = UIImageView() // ➕ yeni ikon

    var onFrequencyTap: (() -> Void)?

    init(title: String, subtitle: String, icon: UIImage) {
        super.init(frame: .zero)
        setupView(title: title, subtitle: subtitle, icon: icon)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(title: String, subtitle: String, icon: UIImage) {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 80).isActive = true

        // Sol ana ikon
        iconView.image = icon
        iconView.tintColor = .systemPurple
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        // Başlık
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = .black

        // Alt başlık
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .darkGray

        subtitleTapButton.translatesAutoresizingMaskIntoConstraints = false
        subtitleTapButton.addTarget(self, action: #selector(frequencyTapped), for: .touchUpInside)

        // Alt başlık container + button
        let subtitleContainer = UIView()
        subtitleContainer.addSubview(subtitleLabel)
        subtitleContainer.addSubview(subtitleTapButton)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: subtitleContainer.topAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: subtitleContainer.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: subtitleContainer.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: subtitleContainer.trailingAnchor),

            subtitleTapButton.topAnchor.constraint(equalTo: subtitleContainer.topAnchor),
            subtitleTapButton.bottomAnchor.constraint(equalTo: subtitleContainer.bottomAnchor),
            subtitleTapButton.leadingAnchor.constraint(equalTo: subtitleContainer.leadingAnchor),
            subtitleTapButton.trailingAnchor.constraint(equalTo: subtitleContainer.trailingAnchor)
        ])

        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleContainer])
        textStack.axis = .vertical
        textStack.spacing = 4

        // Sağ ikon ➕
        rightIconView.image = UIImage(systemName: "plus.circle")
        rightIconView.tintColor = .systemPurple
        rightIconView.contentMode = .scaleAspectFit
        rightIconView.translatesAutoresizingMaskIntoConstraints = false
        rightIconView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        rightIconView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        // Genel Stack
        let stack = UIStackView(arrangedSubviews: [iconView, textStack, rightIconView])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    @objc private func frequencyTapped() {
        onFrequencyTap?()
    }

    func updateSubtitle(_ newSubtitle: String) {
        subtitleLabel.text = newSubtitle
    }
}
