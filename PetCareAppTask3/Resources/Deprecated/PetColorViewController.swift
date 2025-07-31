/*import UIKit

final class PetColorViewController: UIViewController {

    let colorPicker = PetColorPickerView()
    var onNext: ((String) -> Void)?

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İleri", for: .normal)
        button.backgroundColor = UIColor.systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorPicker)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            colorPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nextButton.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func nextTapped() {
        guard let selectedColor = colorPicker.selectedColor else {
            showAlert(message: "Lütfen bir renk seçin.")
            return
        }

        onNext?(selectedColor)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
 */
