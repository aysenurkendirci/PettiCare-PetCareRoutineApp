import UIKit

final class PetTypeSelectorView: UIStackView {
    
    // Artık seçim bildirimi gereksiz, kullanıcı seçim yapamaz
   var onSelectionChanged: ((PetType) -> Void)?
    
    // Dışarıdan atanır — sadece bu tür gösterilecek
    var preselectedType: PetType? {
        didSet {
            if let type = preselectedType {
                selectedType = type
                setupButtons(for: [type]) // Sadece bu türü göster
            }
        }
    }

    private var selectedType: PetType = .cat // Varsayılan
    private let allTypes: [PetType] = PetType.allCases

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        spacing = 12
        distribution = .fillEqually
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Sadece verilen türleri göster
    private func setupButtons(for typesToShow: [PetType]) {
        // Var olan tüm butonları temizle
        arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, type) in typesToShow.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(type.displayName, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemPurple
            button.layer.cornerRadius = 12
            button.tag = index
            button.isUserInteractionEnabled = false // Tek tür gösterildiği için tıklanamaz
            addArrangedSubview(button)
        }
    }

    // Dışarıdan çağrıldığında türü ayarlar
    func setInitialType(from type: PetType) {
        selectedType = type
        setupButtons(for: [type])
    }

    func getSelectedType() -> PetType {
        return selectedType
    }
}
