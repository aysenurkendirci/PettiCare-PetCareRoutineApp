/*import UIKit

final class PetBirthDateViewController: UIViewController {

    private let birthDatePickerView = PetBirthDatePickerView()
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İleri", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    var onNext: ((Date) -> Void)? 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        birthDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(birthDatePickerView)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            birthDatePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            birthDatePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            birthDatePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            birthDatePickerView.heightAnchor.constraint(equalToConstant: 150),

            nextButton.topAnchor.constraint(equalTo: birthDatePickerView.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func nextTapped() {
        let selectedDate = birthDatePickerView.selectedDate

        if Calendar.current.isDate(selectedDate, inSameDayAs: Date()) {
            showAlert(message: "Lütfen doğum tarihi seçiniz.")
            return
        }

        onNext?(selectedDate)
    }
//bugünün tarihinde uyarı verir
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
 }*/
