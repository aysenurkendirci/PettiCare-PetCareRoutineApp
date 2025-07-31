import UIKit

final class PetTypeSelectorView: UIStackView {
    
    // Dışarıdan gelen seçim bildirimi
    var onSelectionChanged: ((PetType) -> Void)?

    // Dışarıdan SwiftData ya da formdan gelen tür buraya atanır
    var preselectedType: PetType? {
        didSet {
            if let type = preselectedType {
                selectedType = type
                updateButtonSelection()
            }
        }
    }

    private let types: [PetType] = PetType.allCases
    private var selectedType: PetType = .cat // Varsayılan, ama didSet ile override ediliyor

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtons() {
        axis = .horizontal
        spacing = 12
        distribution = .fillEqually

        for (index, type) in types.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(type.displayName, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = (type == selectedType) ? .systemPurple : .systemGray5
            button.layer.cornerRadius = 12
            button.tag = index
            button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
            addArrangedSubview(button)
        }
    }

    private func updateButtonSelection() {
        for (i, view) in arrangedSubviews.enumerated() {
            guard let btn = view as? UIButton else { continue }
            let btnType = types[i]
            btn.backgroundColor = (btnType == selectedType) ? .systemPurple : .systemGray5
            btn.setTitleColor((btnType == selectedType) ? .white : .systemPurple, for: .normal)
        }
    }

    @objc private func handleTap(_ sender: UIButton) {
        selectedType = types[sender.tag]
        updateButtonSelection()
        onSelectionChanged?(selectedType)
    }

    // Dışarıdan değer ayarlamak için kullanılabilir (ViewController'dan çağrılır)
    func setInitialType(from type: PetType) {
        selectedType = type
        updateButtonSelection()
    }

    func getSelectedType() -> PetType {
        return selectedType
    }
}
