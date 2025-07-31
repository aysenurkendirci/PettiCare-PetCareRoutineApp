/*import UIKit

class PetTypeViewController: UIViewController {

    private let typePicker = PetTypePickerView()
    private let nextButton = UIButton(type: .system)
    
    var onNext: ((String) -> Void)? // Closure → bir sonraki ekrana veri göndermek için

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.95, blue: 0.93, alpha: 1)
        title = "Evcil Hayvan Türü"

        // Picker
        typePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(typePicker)

        NSLayoutConstraint.activate([
            typePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            typePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Buton
        nextButton.setTitle("İleri", for: .normal)
        nextButton.backgroundColor = UIColor.systemPink
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: typePicker.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    @objc private func nextTapped() {
        guard let selectedType = typePicker.selectedType else {
            showAlert(message: "Lütfen bir tür seçin.")
            return
        }

        onNext?(selectedType) // closure → dışarı gönderiyoruz
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
 }*/
