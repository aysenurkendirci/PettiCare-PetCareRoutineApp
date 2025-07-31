import UIKit

final class RoutineCategorySelectorView: UIStackView {
    private let types: [String] = ["Cat", "Dog", "Bird", "Others"]
    private var selectedType: String = "Cat"
    var onSelectionChanged: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtons() {
        axis = .horizontal
        spacing = 10
        distribution = .fillEqually

        types.forEach { type in
            let button = UIButton(type: .system)
            button.setTitle(type, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = type == selectedType ? UIColor.systemPurple : UIColor.systemBlue.withAlphaComponent(0.2)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            button.layer.cornerRadius = 10
            button.tag = types.firstIndex(of: type) ?? 0
            button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
            addArrangedSubview(button)
        }
    }

    @objc private func didTap(_ sender: UIButton) {
        selectedType = types[sender.tag]
        for case let button as UIButton in arrangedSubviews {
            let isSelected = button.tag == sender.tag
            button.backgroundColor = isSelected ? UIColor.systemPurple : UIColor.systemBlue.withAlphaComponent(0.2)
        }
        onSelectionChanged?(selectedType)
    }
}
