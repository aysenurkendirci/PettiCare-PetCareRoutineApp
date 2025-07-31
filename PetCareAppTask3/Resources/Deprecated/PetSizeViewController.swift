/*import UIKit

final class PetSizeViewController: UIViewController {

    private let sizeInputView = PetSizeInputView()
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İleri", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    var onNext: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        sizeInputView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sizeInputView)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            sizeInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            sizeInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sizeInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sizeInputView.heightAnchor.constraint(equalToConstant: 200),

            nextButton.topAnchor.constraint(equalTo: sizeInputView.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func nextTapped() {
        guard let height = sizeInputView.height, !height.isEmpty,
              let weight = sizeInputView.weight, !weight.isEmpty else {
            showAlert(message: "Lütfen boy ve kilo bilgilerini giriniz.")
            return
        }

        onNext?(height, weight)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
 }*/
