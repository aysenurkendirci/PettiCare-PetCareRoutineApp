import UIKit

final class PetBreedViewController: UIViewController {

    private let breedPickerView = PetBreedPickerView()
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İleri", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    var onNext: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        breedPickerView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(breedPickerView)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            breedPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            breedPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            breedPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            breedPickerView.heightAnchor.constraint(equalToConstant: 150),

            nextButton.topAnchor.constraint(equalTo: breedPickerView.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func nextTapped() {
        guard let selectedBreed = breedPickerView.selectedBreed, !selectedBreed.isEmpty else {
            showAlert(message: "Lütfen bir cins seçiniz.")
            return
        }
        onNext?(selectedBreed)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
