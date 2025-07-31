/*import UIKit

final class PetFeaturesViewController: UIViewController {

    private let featuresView = PetFeaturesView()
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İleri", for: .normal)
        button.backgroundColor = .systemGreen
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
        featuresView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(featuresView)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            featuresView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            featuresView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            featuresView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nextButton.topAnchor.constraint(equalTo: featuresView.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func nextTapped() {
        guard let features = featuresView.selectedFeatures else {
            showAlert(message: "Lütfen bir açıklama girin.")
            return
        }

        onNext?(features)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
 }*/
