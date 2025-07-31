/*import UIKit

final class PetInfoInputView: UIView {

    // MARK: - UI Components
    private let nameField = UITextField()
    private let typeField = UITextField()
    private let breedField = UITextField()
    private let datePicker = UIDatePicker()
    private let weightField = UITextField()
    private let heightField = UITextField()
    private let descriptionField = UITextField()

    // MARK: - Output Values
    var name: String? { nameField.text }
    var type: String? { typeField.text }
    var breed: String? { breedField.text }
    var selectedDate: String? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: datePicker.date)
    }
    var weight: String? { weightField.text }
    var height: String? { heightField.text }
    var details: String? { descriptionField.text }

    // MARK: - Callback'ler (isteğe bağlı)
    var onDateSelected: ((String) -> Void)?
    var onSizeEntered: ((String, String) -> Void)?
    var onInfoEntered: ((String) -> Void)?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFields()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupFields() {
        // Date Picker ayarları
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "tr_TR")

        // Hepsine ortak stil uygulama
        let allFields = [nameField, typeField, breedField, weightField, heightField, descriptionField]
        allFields.forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray4.cgColor
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            $0.setLeftPadding(12)
        }

        // Placeholder'lar
        nameField.placeholder = "Evcil hayvanın adı"
        typeField.placeholder = "Tür (Kedi, Köpek, vb.)"
        breedField.placeholder = "Cins"
        weightField.placeholder = "Ağırlık (kg)"
        heightField.placeholder = "Boy (cm)"
        descriptionField.placeholder = "Açıklama (isteğe bağlı)"

        // Açıklama değiştiğinde callback tetikle
        descriptionField.addTarget(self, action: #selector(descriptionChanged), for: .editingChanged)

        // StackView içinde dikey düzen
        let stack = UIStackView(arrangedSubviews: [
            labeled("Adı", nameField),
            labeled("Tür", typeField),
            labeled("Cinsi", breedField),
            labeled("Doğum Tarihi", datePicker),
            labeled("Ağırlık", weightField),
            labeled("Boy", heightField),
            labeled("Açıklama", descriptionField)
        ])
        stack.axis = .vertical
        stack.spacing = 14
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - Yardımcı Fonksiyonlar
    private func labeled(_ title: String, _ view: UIView) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 14, weight: .medium)
        let stack = UIStackView(arrangedSubviews: [label, view])
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }

    @objc private func descriptionChanged() {
        onInfoEntered?(descriptionField.text ?? "")
    }
 }*/
